resource "spacelift_space" "this" {
  for_each = var.spaces

  name             = each.value.name
  parent_space_id  = each.value.parent_space_id
  description      = each.value.description
  inherit_entities = each.value.inherit_entities
  labels           = each.value.labels
}
