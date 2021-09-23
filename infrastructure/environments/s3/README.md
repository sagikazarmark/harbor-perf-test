# S3 storage environment

This module sets up infrastructure for testing Harbor with S3 storage.


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

Remove the S3 bucket from the state (you'll have to delete that manually):

```shell
terraform state rm aws_s3_bucket.this
```

Destroy the infrastructure using Terraform:

```shell
terraform destroy
```
