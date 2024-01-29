locals{
 local_input = yamldecode(file("./local.yaml"))
 regional_vars    = yamldecode(file(find_in_parent_folders("regional.yaml")))
 tags       = jsondecode(file(find_in_parent_folders("local-tags.json")))
}

include {
  path = find_in_parent_folders()
}

dependency "rg" {
  config_path = "../rg"
  mock_outputs = {
    resource_group_name = "fakeoutput"
  }
}

terraform {
  source = "https://github.com/Matthgd/terraform-module-secondlayer-key-vault.git"
}

inputs = {
 name = local.local_input.name
 location = local.regional_vars.location
 tags = local.tags
 resource_group_name = dependency.rg.resource_group_name
 purge_protection_enabled = local.local_input.purge
}