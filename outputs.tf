output "compute_network" {
  value = {
    name    = google_compute_network.this.name
    id      = google_compute_network.this.id
    subnets = google_compute_subnetwork.this
    nat_ips = var.enable_nat_static_ip ? flatten([for region in local.regions : google_compute_address.nat[*][region].address]) : []
  }
  description = "Name of created network and its subnets."
}

output "vpc_access_connector_name" {
  value       = one(google_vpc_access_connector.this[*].name)
  description = "Name of created access connector (filled if 'cloudrun=true')"
}
