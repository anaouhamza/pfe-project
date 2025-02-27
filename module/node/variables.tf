variable "zone" {
  type = string
  default = "us-west1-c"
}


variable "machine_type" {
  type = string
  default = "e2-medium"
}

variable "machine_type_compute" {
  type = string
  default = "n1-standard-8"
}



variable "image" {
  type = string
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "management_subnet" {}
variable "api_ext_subnet" {}
variable "tunnel_subnet" {}
variable "storage_subnet" {}
variable "management_network" {}
variable "api_ext_network" {}
variable "tunnel_network" {}
variable "storage_network" {}