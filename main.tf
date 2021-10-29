# Here you can reference 2 type of terraform objects :
# 1. Ressources from you provider of choice
# 2. Modules from official repositories which include modules from the following github organizations
#     - AWS: https://github.com/terraform-aws-modules
#     - GCP: https://github.com/terraform-google-modules
#     - Azure: https://github.com/Azure
resource "google_compute_network" "this" {
  auto_create_subnetworks = false
  name                    = var.name
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "this" {
    for_each = {
      for k, v in var.subnets : k => v
    }
    name          = each.key
    ip_cidr_range = each.value.cidr
    region        = each.value.region
    network       = google_compute_network.this.id
}

resource "google_compute_global_address" "this" {
  count        = var.cloudsql ? 1 : 0
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
  count         = var.cloudrun ? 1 : 0
  provider      = google-beta

  name          = length("${var.name}-connector") >= 25 ? "${substr(var.name, 0, 15)}-connector" : "${var.name}-connector"
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.this.name
}

resource "google_project_service" "service" {
  count = var.delete_default_network ? 1 : 0
  service = "compute.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy = false

  provisioner "local-exec" {
    command = "gcloud compute firewall-rules delete default-allow-icmp default-allow-internal default-allow-rdp default-allow-ssh --project=${var.project} && gcloud -q compute networks delete default --project=${var.project}"
  }
}
