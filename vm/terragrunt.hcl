include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///Azure/avm-res-compute-virtualmachine/azurerm?version=0.18.1"
}

dependency "vnet" {
  config_path = "../vnet"
}

dependency "rg" {
  config_path = "../rg"
}

inputs = {
  enable_telemetry    = false
  location            = dependency.rg.outputs.resource.location
  resource_group_name = dependency.rg.outputs.resource.name
  name                = "testvm"
  sku_size            = "Standard_D2ds_v5"
  zone                = 1
  encryption_at_host_enabled = false

  network_interfaces = {
    network_interface_1 = {
      name = "nic"
      ip_configurations = {
        ip_configuration_1 = {
          name                          = "nic-ipconfig1"
          private_ip_subnet_resource_id = dependency.vnet.outputs.subnets["subnet1"].resource_id
        }
      }
    }
  }
}