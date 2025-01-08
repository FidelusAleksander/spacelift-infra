resource "spacelift_space" "this" {
  for_each = { for k, v in var.spaces : v.name => v }

  name             = each.value.name
  parent_space_id  = each.value.parent_space_id
  description      = each.value.description
  inherit_entities = each.value.inherit_entities
  labels           = each.value.labels
}
