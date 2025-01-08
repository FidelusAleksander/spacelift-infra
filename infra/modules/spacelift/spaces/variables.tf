variable "spaces" {
  description = "A map of spaces to create"
  type = map(object({
    parent_space_id  = string
    name             = optional(string, )
    description      = optional(string, )
    inherit_entities = optional(bool, false)
    labels           = optional(set(string), [])
  }))
}
