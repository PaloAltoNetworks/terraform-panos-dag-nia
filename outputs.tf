output "address_groups" {
  value = keys(local.address_group_names)
}

output "tag_to_ip_association" {
  value = local.tags_association
}
