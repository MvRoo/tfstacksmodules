include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "tfr:///Azure/avm-res-resources-resourcegroup/azurerm?version=0.2.1"
}

inputs = {
  location            = "northeurope"
  name                = "tgstackuat"
}