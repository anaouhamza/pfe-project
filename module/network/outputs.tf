output "management_network_self_link" {
    value = google_compute_network.management-network.self_link
}

output "management_subnet_self_link" {
    value = google_compute_subnetwork.management-subnet.self_link
}


output "tunnel_network_self_link" {
    value = google_compute_network.tunnel-network.self_link
}

output "tunnel_subnet_self_link" {
    value = google_compute_subnetwork.tunnel-subnet.self_link 
}

output "storage_network_self_link" {
    value = google_compute_network.storage-network.self_link
}


output "storage_subnet_self_link" {
    value = google_compute_subnetwork.storage-subnet.self_link 
}

output "api_ext_network_self_link" {
    value = google_compute_network.api-ext-network.self_link
}

output "api_ext_subnet_self_link" {
    value = google_compute_subnetwork.api-ext-subnet.self_link
}