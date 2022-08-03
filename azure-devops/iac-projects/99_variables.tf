variable "dev_subscription_name" {
  type        = string
  description = "DEV Subscription name"
}

variable "uat_subscription_name" {
  type        = string
  description = "UAT Subscription name"
}

variable "prod_subscription_name" {
  type        = string
  description = "PROD Subscription name"
}

variable "project_iac_name" {
  type        = string
  description = "Project name for IaC projects"
}

locals {
  project_prefix_short = "cstar"
  azure_devops_org     = "pagopaspa"
  github_org           = "pagopa"

  # 🔐 KV AZDO
  dev_key_vault_resource_group  = "${local.project_prefix_short}-d-sec-rg"
  uat_key_vault_resource_group  = "${local.project_prefix_short}-u-sec-rg"
  prod_key_vault_resource_group = "${local.project_prefix_short}-p-sec-rg"

  dev_key_vault_azdo_name  = "${local.project_prefix_short}-d-azdo-weu-kv"
  uat_key_vault_azdo_name  = "${local.project_prefix_short}-u-azdo-weu-kv"
  prod_key_vault_azdo_name = "${local.project_prefix_short}-p-azdo-weu-kv"

  # 🔐 KV
  dev_key_vault_name  = "${local.project_prefix_short}-d-azdo-weu-kv"
  uat_key_vault_name  = "${local.project_prefix_short}-u-azdo-weu-kv"
  prod_key_vault_name = "${local.project_prefix_short}-p-azdo-weu-kv"
}
