locals {
  regions = toset([
    for x in var.subnets : x.region
  ])
}


resource "google_compute_network" "this" {
  auto_create_subnetworks = false
  name                    = var.name
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "this" {
  for_each = var.subnets
  name          = each.key
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.this.id
}

resource "google_compute_global_address" "this" {
  count         = var.cloudsql ? 1 : 0
  name          = length("${var.name}-db") >= 63 ? "${substr(var.name, 0, 60)}-db" : "${var.name}-db"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.this.id
}

resource "google_service_networking_connection" "this" {
  count                   = var.cloudsql ? 1 : 0
  network                 = google_compute_network.this.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.this[0].name]
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
  depends_on = [
    google_compute_subnetwork.this
  ]

  name    = length("${var.name}-router") >= 63 ? "${substr(var.name, 0, 56)}-router" : "${var.name}-router"
  region  = each.value
  network = var.name

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "this" {
  for_each                           = local.regions
  depends_on = [
    google_compute_subnetwork.this
  ]

  name                               = length("${var.name}-router-nat") >= 63 ? "${substr(var.name, 0, 52)}-router-nat" : "${var.name}-router-nat"
  router                             = google_compute_router.this[each.key].name
  region                             = each.value
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = var.log_config_enable
    filter = var.log_config_filter
  }
}
