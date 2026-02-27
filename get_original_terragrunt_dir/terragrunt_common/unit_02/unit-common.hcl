dependency "unit_01" {
  ############# BUG HITS HERE #####################
  #     ---> version 0.99.4 changed get_original_terragrunt_dir()
  #
  # we needed get_original_terragrunt_dir() as get_terragrunt_dir()) does not
  #     return the path or the original terragrunt.hcl unit file
  config_path = format("%s/../../grandparents/unit_01", get_original_terragrunt_dir())
  # config_path = format("%s/../../grandparents/unit_01", get_terragrunt_dir())

  mock_outputs = {
    pet_parent         = ""
    pet_grandparent    = ""
    pet_name           = ""
    terraform_version  = "0.0.0"
    terragrunt_version = "0.0.0"
  }
}

locals {
  unit_common_local = "unit-common"
}


inputs = {
  pet_parent = dependency.unit_01.outputs.pet_name

  ### for verification using "terragrunt render"
  unit_02_common_get_original_terragrunt_dir = get_original_terragrunt_dir()
  unit_02_common_get_terragrunt_dir          = get_terragrunt_dir()
  unit_02_common_get_repo_root               = get_repo_root()

  unit_02_common_dependency_unit_01_output = dependency.unit_01.outputs
}