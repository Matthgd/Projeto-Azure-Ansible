locals{
 local_input = yamldecode(file("./local.yaml"))
 regional_vars    = yamldecode(file(find_in_parent_folders("regional.yaml")))
 tags       = jsondecode(file(find_in_parent_folders("local-tags.json")))
 vm          = local.local_input.vm
 source_image_reference = local.local_input.image_reference
 ip_configurations = local.local_input.ip_configuration
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
  source = "https://github.com/Matthgd/terraform-module-secondlayer-vm-windows.git"

  after_hook "config-vm" {
    commands     = ["apply"]
    execute      = ["bash", "ansible/ansible.sh", "${get_env("VM-ADMIN-USERNAME")}", "${get_env("VM-ADMIN-PASSWORD")}"]
  }
}


inputs = {
 name = "ANSIBLE-ASADA31"
 location = local.regional_vars.location
 tags = local.tags
 resource_group_name = dependency.rg.outputs.resource_group_name
 admin_username = get_env("VM-ADMIN-USERNAME")
 admin_password = get_env("VM-ADMIN-PASSWORD")
 size = local.vm.size
 source_image_reference = local.source_image_reference
 ip_configurations = local.ip_configurations
 allow_extension_operations = true
}