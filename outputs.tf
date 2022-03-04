output "compute_network" {
  value = {
    name    = google_compute_network.this.name
    id      = google_compute_network.this.id
    subnets = google_compute_subnetwork.this
  }
  description = "Name of created network and its subnets."
}

output "vpc_access_connector_name" {
  value       = one(google_vpc_access_connector.this[*].name)
  # description = "Name of created access connector (filled if 'cloudrun=true')"
}
