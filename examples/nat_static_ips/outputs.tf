output "network" {
  value       = module.my_network.compute_network
  description = "Name of created network and its subnets."
}
