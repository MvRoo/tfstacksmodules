include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
    source = "tfr:///Azure/avm-res-network-virtualnetwork/azurerm?version=0.8.1"
}

dependency "rg" {
  config_path = "../rg"
}

inputs = {
  address_space       = ["10.0.0.0/16"]
  location            = dependency.rg.outputs.resource.location
  name                = "myVNet"
  resource_group_name = dependency.rg.outputs.resource.name
  subnets = {
    "subnet1" = {
      name             = "subnet1"
      address_prefixes = ["10.0.0.0/24"]
    }
    "subnet2" = {
      name             = "subnet2"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}