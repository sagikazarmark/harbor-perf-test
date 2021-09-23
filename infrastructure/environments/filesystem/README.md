# Filesystem (PV) storage environment

This module sets up infrastructure for testing Harbor with filesystem storage (Kubernetes PV).


## Setup

Create a `terraform.tfvars` file.

Then create the VPC (necessary because of some Terraform module limitations):

```shell
terraform apply -target module.testbed.module.vpc
```

Finally, create the rest of the infrastructure:

```shell
terraform apply
```


## Tear down

Destroy the infrastructure using Terraform:

```shell
terraform destroy
```
