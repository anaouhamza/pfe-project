variable "region" {
  type = string
  default = "us-west1"
}

variable "cidr_management" {
  type = string
  default = "10.1.0.0/24"
}

variable "cidr_api_ext" {
  type = string
  default = "172.16.1.0/24"
}

variable "cidr_tunnel" {
  type = string
  default = "192.168.1.0/24"
}

variable "cidr_external" {
  type = string
  default = "192.156.1.0/24"
}


variable "cidr_storage" {
  type = string
  default = "192.123.1.0/24"
}




