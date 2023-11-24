Each top level directory is a separate repository.

# Spacelift manager
Manages the Spacelift infrastructure for the entire organization.

**Includes**:
- spaces
- policies
- user management
- org-level contexts

**Does not include**:
- stacks
- cloud integrations
- stack/app level contexts
- dependencies

# Workloads
> Assumption: Each workload means a separate AWS account. One workload can have multiple applications/microservices/storage stacks

Each directory named `workload-*` is a separate `manager stack` for that workload account.


Each workload manager stack **Includes**:
- For each of the applications/microservices within the workload:
  - An AWS Role with minimal permissions for that application/microservice
  - A spacelift stack
  - A cloud integration for that stack (with the AWS role)
  - example, `workload-a` has 1 web application and 2 microservices, so it has 3 stacks + 3 cloud integrations
- Dependencies between services/applications within the workload
- Contexts attached to the workload stacks
- Plan/Push policies for that workload
- Drift detection settings for each of the stacks
- Blueprints of the stacks, if needed

Each workload manager stack **Does not include**
- Creating spaces
- Dependencies between workloads (should not be needed)


# Org-infrastructure

Organization level infrastructure.

**Includes**:

- ~~An AWS Role with minimal permissions~~  -> Create roles manually, don't attach cloud integration to this manager stack. This stack manages stacks which deploy resources to **multiple** aws accounts.
- A spacelift stack (probably single stack for that account)
- A cloud integration for that stack (with the AWS role that was manually created)
- Plan/Push policies
- Drift detection settings
- Dependencies between stacks
- Contexts for org-level stacks

**Does not include**:
- Creating spaces
- Blueprints
