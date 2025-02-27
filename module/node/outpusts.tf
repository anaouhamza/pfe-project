output "controller_node_h_management_ip" {
  description = "Adresse IP de management du controller-node-h"
  value       = google_compute_instance.controller-node-h.network_interface[0].network_ip
}

output "compute_node_h_management_ip" {
  description = "Adresse IP de management du compute-node-h"
  value       = google_compute_instance.compute-node-h.network_interface[0].network_ip
}

output "network_node_h_management_ip" {
  description = "Adresse IP de management du network-node-h"
  value       = google_compute_instance.network-node-h.network_interface[0].network_ip
}

output "storage_node_h_management_ip" {
  description = "Adresse IP de management du storage-node-h"
  value       = google_compute_instance.storage-node-h.network_interface[0].network_ip
}