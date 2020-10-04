terraform {
  required_providers {
    panos = {
      source  = "paloaltonetworks/panos"
      version = "~>1.6"
    }
  }
}


resource "panos_dag_tags" "example" {
  # https://docs.paloaltonetworks.com/pan-os/9-1/pan-os-admin/policy/register-ip-addresses-and-tags-dynamically

  for_each = var.services
  # vsys name to associate IP address and TAG 
  vsys     = var.vsys_name
  register {    
      # Service or node addess to associate the TAG 
      ip   = each.value.address == "" ? each.value.node_address : each.value.address
      # TAGs based on service name
      tags =  [each.value.name]
  }
}

resource "panos_address_group" "addresses_group" {
  # https://docs.paloaltonetworks.com/pan-os/8-1/pan-os-web-interface-help/objects/objects-address-groups.html

  for_each      = local.service_names
  # Cleanse the service NAME to meet character constraints for addr obj names
  name          = replace("${var.dag_prefix}${each.key}${var.dag_suffix}", "/[^0-9A-Za-z]/", "-")
  # create a match condition based on service name registered in Consul 
  description   = "Dynamic address group generated for service ${each.key} registered in Consul"
  # Add dynamic match based on service name only
  dynamic_match = "'${each.key}'"
}  


locals {
  # Creating a map with key as service name instead of service id
  service_names = transpose({
    for id, s in var.services : id => [s.name]
  })
  # Creating a map for tag to ip address mapping  
  tags_association = {
    for id, s in var.services : s.name => [ (s.address == "" ? s.node_address : s.address)]...
  }
  #Creating a map for address group objects created
  address_group_names = transpose({
    for id, s in var.services : id => [replace("${var.dag_prefix}${s.name}${var.dag_suffix}", "/[^0-9A-Za-z]/", "-")]
  })

}
