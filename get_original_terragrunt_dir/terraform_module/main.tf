terraform {
  required_version = ">= 1.10.0"
}

variable "terragrunt_version" {
  type    = string
  default = "no_info"
}

variable "terraform_version" {
  type    = string
  default = "no_info"
}

variable "pet_parent" {
  type    = string
  default = ""
}

variable "pet_grandparent" {
  type    = string
  default = ""
}

variable "root_common_tg_locals_merged" {
  type    = map(any)
  default = {}
}

variable "unit_common_file_path" {
  type    = string
  default = ""
}

variable "unit_02_dependency_unit_01_config_path" {
  type    = string
  default = ""
}

variable "unit_03_dependency_unit_02_config_path" {
  type    = string
  default = ""
}


resource "terraform_data" "versions" {
  input = {
    terragrunt_version = var.terragrunt_version
    terraform_version  = var.terraform_version
  }
  triggers_replace = {
    terragrunt_version = var.terragrunt_version
    terraform_version  = var.terraform_version
  }
}

resource "random_pet" "this" {
  length    = 3
  separator = " "
}

output "terragrunt_version" {
  value = terraform_data.versions.input.terragrunt_version
}

output "terraform_version" {
  value = terraform_data.versions.input.terraform_version
}

output "pet_parent" {
  value = var.pet_parent
}

output "pet_grandparent" {
  value = var.pet_grandparent
}

output "pet_name" {
  value = random_pet.this.id
}

output "root_common_tg_locals_merged" {
  value = var.root_common_tg_locals_merged
}

output "unit_common_file_path" {
  value = var.unit_common_file_path
}

output "unit_02_dependency_unit_01_config_path" {
  value = var.unit_02_dependency_unit_01_config_path
}

output "unit_03_dependency_unit_02_config_path" {
  value = var.unit_03_dependency_unit_02_config_path
}
