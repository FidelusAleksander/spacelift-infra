module "root_spaces" {
  source = "../modules/spacelift/spaces"

  spaces = {
    workloads = {
      parent_space_id = "root"
      name            = "workloads"
      description     = "Contains all the resources common to the workloads infrastructure."
    }
    infrastructure = {
      parent_space_id = "root"
      name            = "infrastructure"
      description     = "Contains all the resources common to the shared AWS infrastructure (e.g networking hub)."
    }

  }
}

module "workload_spaces" {
  source = "../modules/spacelift/spaces"

  spaces = {
    dev = {
      parent_space_id  = module.root_spaces.spaces["workloads"].id
      name             = "dev"
      description      = "Contains all the resources common to the workloads infrastructure in dev environment."
      inherit_entities = true
    }
    prod = {
      parent_space_id  = module.root_spaces.spaces["workloads"].id
      name             = "prod"
      description      = "Contains all the resources common to the workloads infrastructure in prod environment."
      inherit_entities = true
    }
  }
}
