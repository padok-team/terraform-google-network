locals {
  # Regions list
  regions = flatten([
    for subnet in var.subnets : [
      subnet.region
    ]
  ])

  # VPC Access Connectors map
  vpc_access_connectors = {
    for idx, subnet in values(var.subnets) :
    "${subnet.region}-${idx}" => subnet
    if subnet.serverless_cidr != ""
  }

  # Match the Google VPC module interface
  subnets = [
    for subnet in var.subnets : {
      subnet_name   = subnet.name
      subnet_ip     = subnet.primary_cidr
      subnet_region = subnet.region
    }
  ]

  # Match the Google VPC module interface
  secondary_ranges = {
    for subnet in var.subnets :
    subnet.name => [
      for range in subnet.secondary_ranges :
      {
        range_name    = range.name
        ip_cidr_range = range.cidr
      }
    ]
  }
}

# Create network and its subnets
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.0.0"

  project_id = var.project_id

  network_name            = var.name
  routing_mode            = var.routing_mode
  subnets                 = local.subnets
  secondary_ranges        = local.secondary_ranges
  auto_create_subnetworks = false
  mtu                     = 0

  # TODO : Check if not needed by nat
  # delete_default_internet_gateway_routes = true
}


#
# ROUTER
#

resource "google_compute_router" "router" {
  for_each = toset(local.regions)

  project = var.project_id
  region  = each.key

  name    = "router-${each.key}-${var.name}"
  network = module.vpc.network_name
}


#
# NAT
#

resource "google_compute_address" "ip" {
  for_each = toset(local.regions)

  project = var.project_id
  region  = each.key

  name         = "nat-${each.key}-${var.name}"
  address_type = "EXTERNAL"
  purpose      = null
  network_tier = "PREMIUM"
}

resource "google_compute_router_nat" "nat" {
  for_each = toset(local.regions)

  project = var.project_id

  name   = "nat-${google_compute_router.router[each.key].name}"
  router = google_compute_router.router[each.key].name
  region = google_compute_router.router[each.key].region

  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  nat_ips                             = [google_compute_address.ip[each.key].self_link]
  min_ports_per_vm                    = 0
  udp_idle_timeout_sec                = 30
  icmp_idle_timeout_sec               = 30
  tcp_established_idle_timeout_sec    = 1200
  tcp_transitory_idle_timeout_sec     = 30
  enable_endpoint_independent_mapping = true

  log_config {
    enable = true
    filter = "ALL"
  }
}

#
# PEERING GOOGLE NETWORK SERVICES
#

resource "google_compute_global_address" "gcp_services_peering" {
  count = var.gcp_peering_cidr == "" ? 0 : 1

  project = var.project_id

  name          = "gcp-services-peering-${var.name}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = split("/", var.gcp_peering_cidr)[1]
  address       = split("/", var.gcp_peering_cidr)[0]
  network       = module.vpc.network_id
}

resource "google_service_networking_connection" "default" {
  count = length(google_compute_global_address.gcp_services_peering)

  network                 = module.vpc.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.gcp_services_peering[count.index].name]
}

#
# SERVERLESS
#

resource "google_vpc_access_connector" "default" {
  for_each = local.vpc_access_connectors

  project = var.project_id
  region  = each.value.region

  name          = each.key
  ip_cidr_range = each.value.serverless_cidr
  network       = module.vpc.network_name
}
