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
  description = "Name of created access connector (filled if 'cloudrun=true')"
}

output "nat_static_ips" {
  value       = { for key, value in data.google_compute_address.nat : key => value.address }
  description = "Map of IPs if NAT Static IP Flag is enabled"
}
