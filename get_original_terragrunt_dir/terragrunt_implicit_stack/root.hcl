locals {
  root_local = "root"
}

inputs = {
  # unit inputs mostly from unit-common.hcl
  root_get_original_terragrunt_dir = get_original_terragrunt_dir()
  root_get_parent_terragrunt_dir   = get_parent_terragrunt_dir()
  root_get_terragrunt_dir          = get_terragrunt_dir()
  root_get_repo_root               = get_repo_root()
}
