locals {
  regions = toset([
    for x in var.subnets : x.region
  ])

  range_names = [for k, v in var.peerings : length("${var.name}-${k}") >= 63 ? "${substr(var.name, 0, length("${k}"))}" : "${var.name}-${k}"]
}


resource "google_compute_network" "this" {
  auto_create_subnetworks = false
  name                    = var.name
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "this" {
  for_each      = var.subnets
  name          = each.key
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.this.id
}

resource "google_compute_global_address" "peering" {
  for_each = var.peerings

  name          = length("${var.name}-${each.key}") >= 63 ? "${substr(var.name, 0, length("${each.key}"))}" : "${var.name}-${each.key}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = each.value.prefix
  address       = each.value.address
  network       = google_compute_network.this.id
}

resource "google_service_networking_connection" "this" {
  count                   = length(var.peerings) > 0 ? 1 : 0
  network                 = google_compute_network.this.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = local.range_names

  depends_on = [
    google_compute_global_address.peering
  ]
}

resource "google_vpc_access_connector" "this" {
  count    = var.cloudrun ? 1 : 0
  provider = google-beta

  name          = length("${var.name}-connector") >= 25 ? "${substr(var.name, 0, 15)}-connector" : "${var.name}-connector"
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.this.name
}

resource "google_compute_router" "this" {
  for_each = local.regions

  name    = length("${var.name}-router") >= 63 ? "${substr(var.name, 0, 56)}-router" : "${var.name}-router"
  region  = each.value
  network = var.name

  bgp {
    asn = 64514
  }

  depends_on = [
    google_compute_subnetwork.this
  ]
}

resource "google_compute_address" "nat" {
  for_each = {
    for value in local.regions : value => value
    if var.enable_nat_static_ip
  }

  name   = length("${var.name}-${each.value}-nat") >= 63 ? "${substr(var.name, 0, 58 - length(each.value))}-${each.value}-nat" : "${var.name}-${each.value}-nat"
  region = each.value

  address_type = "EXTERNAL"
}

resource "google_compute_router_nat" "this" {
  for_each = local.regions

  name                               = length("${var.name}-router-nat") >= 63 ? "${substr(var.name, 0, 52)}-router-nat" : "${var.name}-router-nat"
  router                             = google_compute_router.this[each.key].name
  region                             = each.value
  nat_ip_allocate_option             = var.enable_nat_static_ip ? "MANUAL_ONLY" : "AUTO_ONLY"
  nat_ips                            = var.enable_nat_static_ip ? [google_compute_address.nat[each.value].self_link] : []
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = var.log_config_enable
    filter = var.log_config_filter
  }

  depends_on = [
    google_compute_subnetwork.this
  ]
}
