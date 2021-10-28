output "network" {
  value       = {
    name = google_compute_network.this.name
    subnets = google_compute_subnetwork.this
  }
}
