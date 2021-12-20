output "network" {
  value = {
    name    = google_compute_network.this.name
    id      = google_compute_network.this.id
    subnets = google_compute_subnetwork.this
  }
  description = "Name, ID and subnets of created network."
}
