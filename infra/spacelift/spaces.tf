resource "spacelift_space" "workloads" {
  name            = "workloads"
  parent_space_id = "root"
  description     = "Contains all the resources common to the workloads infrastructure."
}


resource "spacelift_space" "workloads-dev" {
  name             = "dev"
  parent_space_id  = spacelift_space.workloads.id
  inherit_entities = true
  description      = "Contains all the resources common to the workloads infrastructure in dev environment."
}

resource "spacelift_space" "workloads-prod" {
  name             = "prod"
  parent_space_id  = spacelift_space.workloads.id
  inherit_entities = true
  description      = "Contains all the resources common to the workloads infrastructure in prod environment."
}

resource "spacelift_space" "infrastructure" {
  name            = "infrastructure"
  parent_space_id = "root"
  description     = "Contains all the resources common to the shared AWS infrastructure (e.g networking hub)."
}


module "spaces" {
  source = "../modules/spacelift/spaces"

  spaces = {
    something-key = {
      parent_space_id = "root"
      name            = "something"
    },
    something-key2 = {
      parent_space_id = "something-key"
      name            = "something2"
    }
  }
}
