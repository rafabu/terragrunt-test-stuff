locals {
  unit_common_local = "unit-common"
}


inputs = {
  ### for verification using "terragrunt render"
  unit_01_common_get_original_terragrunt_dir = get_original_terragrunt_dir()
  unit_01_common_get_terragrunt_dir          = get_terragrunt_dir()
  unit_01_common_get_repo_root               = get_repo_root()
}