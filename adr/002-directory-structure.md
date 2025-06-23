# Directory Structure


## Issue
This repo should be extensible for multi-environment set up and easy to follow

## Decision
Split repo by environments, and have a common modules folder, application will in a separate folder on the root

**Explanation:**
* **`.github`**: Contains github actions gitops
* **`adr`**: Contains an architectural decision record
* **`docker`**: Contains all applications
  * **`application-name`**: Contains code for app "application-name"
* **`terraform`**: Contains all terraform infra code
  * **`environments/`**: Contains environment-specific Terraform configurations (e.g., `prod`, `dev`, `staging`). This allows for consistent module usage with different variable values.
  * **`modules/`**: Contains reusable Terraform modules.
  * **`modules/vpc/`**: Encapsulates the entire VPC network stack, including public/private subnets, internet gateway, NAT gateway, and core security groups. This module is designed to be reusable.

## Status
Accepted
