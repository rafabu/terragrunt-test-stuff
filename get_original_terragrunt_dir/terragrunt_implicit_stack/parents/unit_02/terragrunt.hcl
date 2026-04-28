
include "root" {
  path           = find_in_parent_folders("root.hcl")
  expose         = false
  merge_strategy = "deep"
}

include "root-common" {
  path           = format("%s/get_original_terragrunt_dir/terragrunt_common/root-common.hcl", get_repo_root())
  expose         = false
  merge_strategy = "deep"
}

include "level" {
  path           = find_in_parent_folders("level.hcl")
  expose         = false
  merge_strategy = "deep"
}

include "unit-common" {
  path           = format("%s/get_original_terragrunt_dir/terragrunt_common/%s/unit-common.hcl", get_repo_root(), basename(get_terragrunt_dir()))
  expose         = false
  merge_strategy = "deep"
}

inputs = {
  ### for verification using "terragrunt render"
  unit_02_get_original_terragrunt_dir = get_original_terragrunt_dir()
  unit_02_get_parent_terragrunt_dir   = get_parent_terragrunt_dir("root")
  unit_02_get_path_from_repo_root     = get_path_from_repo_root()
  unit_02_get_path_to_repo_root       = get_path_to_repo_root()
  unit_02_get_repo_root               = get_repo_root()
  unit_02_get_terragrunt_dir          = get_terragrunt_dir()
  unit_02_get_working_dir             = get_working_dir()
}

