resource "google_compute_network" "management-network" {
  name = "management-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "management-subnet" {
  name          = "management-subnet"
  ip_cidr_range = var.cidr_management
  region        = var.region
  network       = google_compute_network.management-network.id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  project = "profound-gantry-451609-g0"
  network = google_compute_network.management-network.name  # Remplace par le nom de ton réseau
  
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]  # Autorise tout le monde à se connecter en SSH
  target_tags   = ["allow-ssh"] # Tag à associer aux VMs pour appliquer la règle
  priority      = 1000
}


resource "google_compute_network" "api-ext-network" {
  name = "api-ext-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "api-ext-subnet" {
  name          = "api-ext-subnet"
  ip_cidr_range = var.cidr_api_ext
  region        = var.region
  network       = google_compute_network.api-ext-network.id
}


resource "google_compute_network" "tunnel-network" {
  name = "tunnel-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "tunnel-subnet" {
  name          = "tunnel-subnet"
  ip_cidr_range = var.cidr_tunnel
  region        = var.region
  network       = google_compute_network.tunnel-network.id
}



resource "google_compute_network" "storage-network" {
  name = "storage-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "storage-subnet" {
  name          = "storage-subnet"
  ip_cidr_range = var.cidr_storage
  region        = var.region
  network       = google_compute_network.storage-network.id
}





