# OpenTofu Infrastructure

This repository contains OpenTofu configurations for managing various infrastructure components across different environments.

The infrastructure is deployed through [Spacelift](https://spacelift.io/).

#

## Repository Structure



```
infra
├── modules                 # Reusable modules
│   ├── aws                 # AWS modules
│   └── spacelift           # Spacelift modules
└── shared-services         # Root modules for shared-services account
├── spacelift               # Root module for Spacelift account configuration
└── workloads               # Root modules for different AWS workloads
```
