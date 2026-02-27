dependency "unit_02" {
  ############# BUG HITS HERE #####################
  #     ---> version 0.99.4 changed get_original_terragrunt_dir()
  #
  # we needed get_original_terragrunt_dir() as get_terragrunt_dir()) does not
  #     return the path or the original terragrunt.hcl unit file
  config_path = format("%s/../../parents/unit_02", get_original_terragrunt_dir())
  #config_path = format("%s/../../parents/unit_02", get_terragrunt_dir())

  mock_outputs = {
    pet_grandparent    = ""
    pet_parent         = ""
    pet_name           = ""
    terraform_version  = "0.0.0"
    terragrunt_version = "0.0.0"
  }
}

locals {
  unit_common_local = "unit-common"
}


inputs = {
  pet_parent      = dependency.unit_02.outputs.pet_name
  pet_grandparent = dependency.unit_02.outputs.pet_parent

  ### for verification using "terragrunt render"
  unit_03_common_get_original_terragrunt_dir = get_original_terragrunt_dir()
  unit_03_common_get_terragrunt_dir          = get_terragrunt_dir()
  unit_03_common_get_repo_root               = get_repo_root()

  unit_03_common_dependency_unit_02_output = dependency.unit_02.outputs
}