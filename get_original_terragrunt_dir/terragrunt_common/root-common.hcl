locals {

  # due to legacy requirements, build a merged config of the locals, allowing
  #     to set certain defaults here at the root-common.hcl instead of the indifidual unit's terragrunt.hcl files
  root_tg = read_terragrunt_config(format("%s/../../root.hcl", get_terragrunt_dir()))
  # root_tg = read_terragrunt_config(find_in_parent_folders("root.hcl"), {inputs = {}})
  level_tg = read_terragrunt_config(format("%s/../level.hcl", get_terragrunt_dir()))
  unit_common_tg = read_terragrunt_config(format(
    "%s/get_original_terragrunt_dir/terragrunt_common/%s/unit-common.hcl",
    get_repo_root(),
    regexall("^.*/(.+?)$", get_terragrunt_dir())[0][0]
  ))

  merged_tg_locals = merge(
    local.root_tg.locals,
    local.level_tg.locals,
    local.unit_common_tg.locals
  )

  # get versions of both terragrunt anf terraform for dummy module output
  terragrunt_version = try(regexall("[0-9]+\\.[0-9]+\\.[0-9]+$", trimspace(
    run_cmd(
      "--terragrunt-quiet",
      "terragrunt",
      "--version"
    )
  ))[0], "invalid_version")
  terraform_version = try(jsondecode(trimspace(
    run_cmd(
      "--terragrunt-quiet",
      "terraform",
      "-version",
      "-json"
    )
  )).terraform_version, "invalid_version")
}

terraform {
  source = format("%s/get_original_terragrunt_dir/terraform_module", get_repo_root())
}

# defined local backend for each unit (otherwise dependency reads fail)
generate "backend_local" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
  terraform {
    backend "local" {
      path = "${get_terragrunt_dir()}/terraform.tfstate"
    }
  }
  EOF
}

inputs = {
  ### actual terraform module inputs
  terragrunt_version = local.terragrunt_version
  terraform_version  = local.terraform_version

  ### for verification using "terragrunt render"
  root_common_get_original_terragrunt_dir = get_original_terragrunt_dir()
  root_common_get_terragrunt_dir          = get_terragrunt_dir()
  root_common_get_repo_root               = get_repo_root()

  root_common_tg_locals_merged = local.merged_tg_locals
}
