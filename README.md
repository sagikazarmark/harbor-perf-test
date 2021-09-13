# Harbor Performance Tests

This repo contains tools to run performance tests on Harbor.


## Prerequisites

The tools in this repository use [AWS](https://aws.amazon.com/) for running Harbor and the performances tests,
so you'll need an AWS account.

You'll also have to be familiar with [Terraform](https://www.terraform.io/) to create test environments.

The performance test suite relies uses [k6](https://k6.io/).
Getting to know it a little bit before running large test suites doesn't hurt.


## Preparations

Take a look at the example environments under [infrastructure/environments/](infrastructure/environments/).
Create one (or more) environment that reflects what you would like to test (eg. different HA setups or different storage solutions).

Alternatively, you can reuse one of the existing environments:

1. Create a `terraform.tfvars` file in the environment directory with the necessary values
2. Run `terraform apply`
3. Run `ssh ubuntu@$(terraform output -raw test_executor_ip)` to SSH into the test executor machine
4. Run your tests!


## Running performance tests

The Harbor project has a performance test suite of its own: https://github.com/goharbor/perf

The test executor machine comes with this test suite (and the relvant tools) pre-installed.

You can follow the instructions in the repository to run the test suite
or you can run the tests manually:

1. Load test data into Harbor by running `k6 run scripts/data/SCRIPT_NAME`
2. Run the individual tests by running `k6 run scripts/test/SCRIPT_NAME`

For small tests, you might want to consider to set VUs to a lower number than the default in each test case.
If you use the original (magefile) execution strategy, you can do that by setting the `HARBOR_VUS` environment variable.


## Cleaning up

Although Terraform should be able to clean up after itself, that's not always the case.
For example, it cannot delete S3 buckets while there is data in them.
So before destroying the infrastructure, think about resources that might need manual cleanup.

Then run `terraform destroy` to destroy the test environment.


## Further tips

### Using an existing EKS cluster

When using an existing EKS cluster, you need to make sure that you can access the cluster
(even though you don't have to interact with it).
This is necessary because Terraform uses the AWS IAM authenticator internally (or rather mimics its behavior)
to generate a short-lived token for accessing the cluster.

To gain access to the cluster, you either have to create the cluster or have to add an entry to the `aws-auth`
configmap in the `kube-system` namespace. More details in the [official documentation](https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html).

For example, you can add the following to the `mapRoles` section in the configmap:

```yaml
    - rolearn: <ARN of role>
      username: admin
      groups:
        - system:masters
```

Alternatively, you can use this oneliner to do the same:

```shell
ROLE_ARN="<ARN of role>"
ROLE="    - rolearn: ${ROLE_ARN}\n      username: admin\n      groups:\n        - system:masters"
kubectl get -n kube-system configmap/aws-auth -o yaml | awk "/mapRoles: \|/{print;print \"$ROLE\";next}1" > /tmp/aws-auth-patch.yml
kubectl patch configmap/aws-auth -n kube-system --patch "$(cat /tmp/aws-auth-patch.yml)"
rm -rf /tmp/aws-auth-patch.yml
```


## References

- [Harbor Operator performance docs](https://github.com/goharbor/harbor-operator/blob/master/docs/perf/simple-perf-comprasion.md)
- [Harbor performance test suite](https://github.com/goharbor/perf)
