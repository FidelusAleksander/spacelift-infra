moved {
  from = spacelift_space.infrastructure
  to   = module.root_spaces.spacelift_space.this["infrastructure"]
}

moved {
  from = spacelift_space.workloads
  to   = module.root_spaces.spacelift_space.this["workloads"]
}

moved {
  from = spacelift_space.workloads-dev
  to   = module.workload_spaces.spacelift_space.this["dev"]
}

moved {
  from = spacelift_space.workloads-prod
  to   = module.workload_spaces.spacelift_space.this["prod"]
}
