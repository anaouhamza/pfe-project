module "network" {
  source = "./module/network"
}


module "node" {
  source = "./module/node"
  management_network = module.network.management_network_self_link
  api_ext_network = module.network.api_ext_network_self_link
  tunnel_network = module.network.tunnel_network_self_link
  storage_network = module.network.storage_network_self_link
  management_subnet = module.network.management_subnet_self_link
  api_ext_subnet   = module.network.api_ext_subnet_self_link
  tunnel_subnet    = module.network.tunnel_subnet_self_link
  storage_subnet   = module.network.storage_subnet_self_link
}


