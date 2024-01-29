locals{
 local_input = yamldecode(file("./local.yaml"))
 regional_vars    = yamldecode(file(find_in_parent_folders("regional.yaml")))
 tags       = jsondecode(file(find_in_parent_folders("local-tags.json")))
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "https://github.com/Matthgd/terraform-module-secondlayer-resource-group.git"
}

inputs = {
 name = local.local_input.name
 location = local.regional_vars.location
 tags = local.tags
}