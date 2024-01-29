locals {
  tfstate  = yamldecode(file("./tfstate.yaml"))
}

generate "provider" {
  path      = "provider.g.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
}
EOF
}

remote_state {
  backend = "azurerm"
  config = {
    storage_account_name = local.tfstate.azurerm.storage_account_name
    resource_group_name  = local.tfstate.azurerm.resource_group_name
    container_name       = local.tfstate.azurerm.container_name
    key                  = "project/${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.g.tf"
    if_exists = "overwrite_terragrunt"
  }
}

