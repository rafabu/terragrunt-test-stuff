# terragrunt-test-stuff

just a few test cases for terragrunt and terraform

## get_original_terragrunt_dir() test - 2026/02/25

terragrunt v0.99.4 broke involved stacks since the behaviour of get_original_terragrunt_dir() changed.

This terragrunt IMPLICIT stack runs a very basic terraform module to produce some output. Local state is used; no
network connectivity or other infrastructure required.

run the test as follows:

``` bash
cd ./get_original_terragrunt_dir/

terragrunt run apply --all
```

### Expected Behaviour (pre v0.99.4)

terragrunt will happily run the entire implicit stack which generates just a few silly terraform outputs.

``` txt

[terragrunt_implicit_stack\children\unit_03] terraform:
[terragrunt_implicit_stack\children\unit_03] terraform: Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
[terragrunt_implicit_stack\children\unit_03] terraform:
[terragrunt_implicit_stack\children\unit_03] terraform: Outputs:
[terragrunt_implicit_stack\children\unit_03] terraform: pet_grandparent = "gently curious doe"
[terragrunt_implicit_stack\children\unit_03] terraform: pet_name = "greatly evolved quetzal"
[terragrunt_implicit_stack\children\unit_03] terraform: pet_parent = "publicly better quail"
[terragrunt_implicit_stack\children\unit_03] terraform: terraform_version = "1.14.5"
[terragrunt_implicit_stack\children\unit_03] terraform: terragrunt_version = "0.99.3"

```

### Error Behaviour (v0.99.4)

terragrunt fails as it can no longer evaluate the dependency statements of terragrunt_common unit_02 and unit_03 which in turn makes the root_common.hcl read_terragrunt_config fail.

``` txt

ERROR  Error: Error in function call
ERROR    on ./get_original_terragrunt_dir/terragrunt_common/root-common.hcl line 8, in locals:
ERROR     8:   unit_common_tg = read_terragrunt_config(format(
ERROR     9:     "%s/get_original_terragrunt_dir/terragrunt_common/%s/unit-common.hcl",
ERROR    10:     get_repo_root(),
ERROR    11:     regexall("^.*/(.+?)$", get_terragrunt_dir())[0][0]
ERROR    12:   ))
ERROR  Call to function "read_terragrunt_config" failed: error occurred:
ERROR  * ./get_original_terragrunt_dir/terragrunt_common/unit_03/unit-common.hcl:25,21-31: Unknown variable; There is no variable named "dependency"., and 2 other diagnostic(s)
ERROR  .
ERROR  Error: Error in function call
ERROR    on ./get_original_terragrunt_dir/terragrunt_common/root-common.hcl line 8, in locals:
ERROR     8:   unit_common_tg = read_terragrunt_config(format(
ERROR     9:     "%s/get_original_terragrunt_dir/terragrunt_common/%s/unit-common.hcl",
ERROR    10:     get_repo_root(),
ERROR    11:     regexall("^.*/(.+?)$", get_terragrunt_dir())[0][0]
ERROR    12:   ))
ERROR  Call to function "read_terragrunt_config" failed: error occurred:
ERROR  * ./get_original_terragrunt_dir/terragrunt_common/unit_02/unit-common.hcl:25,16-26: Unknown variable; There is no variable named "dependency"., and 1 other diagnostic(s)
ERROR  .
ERROR  error occurred:

* ./get_original_terragrunt_dir/terragrunt_common/root-common.hcl:8,20-43: Error in function call; Call to function "read_terragrunt_config" failed: error occurred:

  * ./get_original_terragrunt_dir/terragrunt_common/unit_03/unit-common.hcl:25,21-31: Unknown variable; There is no variable named "dependency"., and 2 other diagnostic(s)
  .

error occurred:

* ./get_original_terragrunt_dir/terragrunt_common/root-common.hcl:8,20-43: Error in function call; Call to function "read_terragrunt_config" failed: error occurred:

  * ./get_original_terragrunt_dir/terragrunt_common/unit_02/unit-common.hcl:25,16-26: Unknown variable; There is no variable named "dependency"., and 1 other diagnostic(s)
  .

ERROR  Unable to determine underlying exit code, so Terragrunt will exit with error code 1

```

### Analysis

The `unit-common.hcl` ind _./terragrunt_common/_ configurations had to make use of the get_original_terragrunt_dir() function to reliably create a dependency on the upstream unit. This does and did never work with get_terragrunt_dir().
In conjunction with loading the config as well in root_common.hcl  using read_terragrunt_config() - line 8 - everything falls apart with v0.99.4.

The latter is used in production to support various, partly legacy unit gimmicks. Near impossible to refactor so it hurts that the behaviour of get_original_terragrunt_dir() has changed.

So far I was not able to find any workaround :-(

#### Side note on terragrunt render

Analysing things with `terragrunt render` actually broke with `v0.98.0` already. While this works with v0.97.2 and earlier:

``` bash
terragrunt render --all 
```

it will fail with >= v0.98.0
