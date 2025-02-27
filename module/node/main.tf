resource "tls_private_key" "bastion_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "bastion_private_key" {
  content  = tls_private_key.bastion_ssh_key.private_key_pem
  filename = "${path.root}/ssh_keys/bastion_ssh_key.pem"
}

resource "tls_private_key" "compute_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "compute_private_key" {
  content  = tls_private_key.compute_ssh_key.private_key_pem
  filename = "${path.root}/ssh_keys/compute_ssh_key.pem"
}

resource "tls_private_key" "controller_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "controller_private_key" {
  content  = tls_private_key.controller_ssh_key.private_key_pem
  filename = "${path.root}/ssh_keys/controller_ssh_key.pem"
}

resource "tls_private_key" "network_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "network_private_key" {
  content  = tls_private_key.network_ssh_key.private_key_pem
  filename = "${path.root}/ssh_keys/network_ssh_key.pem"
}

resource "tls_private_key" "storage_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "storage_private_key" {
  content  = tls_private_key.storage_ssh_key.private_key_pem
  filename = "${path.root}/ssh_keys/storage_ssh_key.pem"
}




resource "google_compute_instance" "bastion-node-h" {
  name         = "bastion-node-h"
  machine_type = var.machine_type  
  zone         = var.zone
  allow_stopping_for_update = true
  depends_on = [ var.management_subnet ]

  tags = ["allow-ssh"] # Ajout du tag pour appliquer la règle de pare-feu

  # Image Ubuntu 22.04 LTS
  boot_disk {
    initialize_params {
      image = var.image
      size  = 100
    }
  }

  # Clé SSH
  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.bastion_ssh_key.public_key_openssh}"
  }

  # Interface réseau pour le réseau de management
  network_interface {
    network = var.management_network
    subnetwork = var.management_subnet
    access_config {  
    }
  }




}


resource "google_compute_instance" "controller-node-h" {
  name         = "controller-node-h"
  machine_type = var.machine_type  
  zone         = var.zone
  allow_stopping_for_update = true
  depends_on = [ var.management_subnet, var.api_ext_subnet ]

  # Image Ubuntu 22.04 LTS
  boot_disk {
    initialize_params {
      image = var.image
      size  = 100
    }
  }

  # Clé SSH
  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.controller_ssh_key.public_key_openssh}"
  }

  # Interface réseau pour le réseau de management
  network_interface {
    network = var.management_network
    subnetwork = var.management_subnet
  }

  # Interface réseau pour le réseau api-ext
  network_interface {
    network = var.api_ext_network
    subnetwork = var.api_ext_subnet
  }

}


resource "google_compute_instance" "compute-node-h" {
  name         = "compute-node-h"
  machine_type = var.machine_type_compute
  zone         = var.zone
  allow_stopping_for_update = true
  depends_on = [ var.management_subnet, var.tunnel_subnet, var.storage_subnet]

  # Image Ubuntu 22.04 LTS
  boot_disk {
    initialize_params {
      image = var.image
      size  = 100
    }
  }

  # Clé SSH
  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.compute_ssh_key.public_key_openssh}"  
  }

  # Interface réseau pour le réseau de management
  network_interface {
    network    = var.management_network
    subnetwork = var.management_subnet
  }

  # Interface réseau pour le réseau tunnel
  network_interface {
    network    = var.tunnel_network
    subnetwork = var.tunnel_subnet
  }

  # Interface réseau pour le réseau storage
  network_interface {
    network    = var.storage_network
    subnetwork = var.storage_subnet
  }

  advanced_machine_features {
    enable_nested_virtualization = true
  }
}

resource "google_compute_instance" "network-node-h" {
  name         = "network-node-h"
  machine_type = var.machine_type  
  zone         = var.zone
  allow_stopping_for_update = true
  depends_on = [ var.management_subnet, var.tunnel_subnet ]

  # Image Ubuntu 22.04 LTS
  boot_disk {
    initialize_params {
      image = var.image
      size  = 100
    }
  }

  # Clé SSH
  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.network_ssh_key.public_key_openssh}"  
  }

  # Interface réseau pour le réseau de management
  network_interface {
    network    = var.management_network
    subnetwork = var.management_subnet
  }

  # Interface réseau pour le réseau tunnel
  network_interface {
    network    = var.tunnel_network
    subnetwork = var.tunnel_subnet
  }
}

resource "google_compute_instance" "storage-node-h" {
  name         = "storage-node-h"
  machine_type = var.machine_type  
  zone         = var.zone
  allow_stopping_for_update = true
  depends_on = [ var.management_subnet, var.storage_subnet ]

  # Image Ubuntu 22.04 LTS
  boot_disk {
    initialize_params {
      image = var.image
      size  = 100
    }
  }

  # Clé SSH
  metadata = {
    ssh-keys = "ubuntu:${tls_private_key.storage_ssh_key.public_key_openssh}"  
  }

  # Interface réseau pour le réseau de management
  network_interface {
    network    = var.management_network
    subnetwork = var.management_subnet
  }

  # Interface réseau pour le réseau storage
  network_interface {
    network    = var.storage_network
    subnetwork = var.storage_subnet
    }
}