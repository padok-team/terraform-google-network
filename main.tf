locals {
  regions = flatten([
    for v in var.subnets : [
      v.subnet_region
    ]
  ])
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.0.0"

  project_id                             = var.project_id
  network_name                           = var.network_name
  routing_mode                           = var.routing_mode
  description                            = var.description
  auto_create_subnetworks                = var.auto_create_subnetworks
  subnets                                = var.subnets
  mtu                                    = var.mtu
  secondary_ranges                       = var.secondary_ranges
  routes                                 = var.routes
  firewall_rules                         = var.firewall_rules
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
}

module "nat_addresses" {
  source  = "terraform-google-modules/address/google"
  version = "3.1.1"

  for_each = toset(local.regions)

  region       = each.key
  names        = ["nat-${var.network_name}-${each.key}"]
  project_id   = var.project_id
  address_type = "EXTERNAL"
}

module "router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "1.3.0"

  for_each = toset(local.regions)

  name    = "${var.network_name}-${each.key}"
  project = var.project_id
  region  = each.key
  network = module.vpc.network_name
  nats = [{
    name    = "${var.network_name}-${each.key}"
    nat_ips = module.nat_addresses[each.key].self_links
  }]
}

resource "google_compute_global_address" "gcp-services" {
  name          = "${var.network_name}-gcp-services"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  project       = var.project_id
  prefix_length = split("/", var.gcp_services_cidr)[1]
  address       = split("/", var.gcp_services_cidr)[0]
  network       = module.vpc.network_id
}

resource "google_service_networking_connection" "default" {
  network                 = module.vpc.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.gcp-services.name]
}

resource "google_vpc_access_connector" "default" {
  for_each = {
    for value in var.vpc_serverless_connectors : "${value.name}" => value
  }

  project        = var.project_id
  max_throughput = 800
  name           = each.value.name
  region         = each.value.region
  ip_cidr_range  = each.value.cidr
  network        = module.vpc.network_name
}
