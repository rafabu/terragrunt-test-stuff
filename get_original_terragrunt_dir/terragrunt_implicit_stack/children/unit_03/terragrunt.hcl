
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
  path           = format("%s/get_original_terragrunt_dir/terragrunt_common/%s/unit-common.hcl", get_repo_root(), regexall("^.*/(.+?)$", get_terragrunt_dir())[0][0])
  expose         = false
  merge_strategy = "deep"
}

inputs = {
  ### for verification using "terragrunt render"
  unit_03_get_original_terragrunt_dir = get_original_terragrunt_dir()
  unit_03_get_terragrunt_dir          = get_terragrunt_dir()
  unit_03_get_repo_root               = get_repo_root()
}

