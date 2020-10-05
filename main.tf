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


locals {
  # Creating a map for tag to ip address mapping  
  tags_association = {
    for id, s in var.services : s.name => [ (s.address == "" ? s.node_address : s.address)]...
  }
}
