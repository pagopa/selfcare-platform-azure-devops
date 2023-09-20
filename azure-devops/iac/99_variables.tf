locals {
  project_prefix_short = "selc"
  azure_devops_org     = "pagopaspa"
  github_org           = "pagopa"
  prefix               = "selc"

  # 🔐 KV AZDO
  prod_key_vault_resource_group = "${local.prefix}-p-sec-rg"
  prod_key_vault_azdo_name = "${local.prefix}-p-kv"

  # 🔐 SELFCARE PNPG KV Domain
  dev_selfcare_key_vault_resource_group   = "${local.prefix}-d-sec-rg"
  uat_selfcare_key_vault_resource_group   = "${local.prefix}-u-sec-rg"
  prod_selfcare_key_vault_resource_group  = "${local.prefix}-p-sec-rg"

  dev_selfcare_key_vault_name   = "${local.prefix}-d-kv"
  uat_selfcare_key_vault_name   = "${local.prefix}-u-kv"
  prod_selfcare_key_vault_name  = "${local.prefix}-p-kv"

  # 🔐 SELFCARE PNPG KV Domain
  dev_selfcare_pnpg_key_vault_resource_group  = "${local.prefix}-d-pnpg-sec-rg"
  uat_selfcare_pnpg_key_vault_resource_group  = "${local.prefix}-u-pnpg-sec-rg"
  prod_selfcare_pnpg_key_vault_resource_group = "${local.prefix}-p-pnpg-sec-rg"

  dev_selfcare_pnpg_key_vault_name  = "${local.prefix}-d-pnpg-kv"
  uat_selfcare_pnpg_key_vault_name  = "${local.prefix}-u-pnpg-kv"
  prod_selfcare_pnpg_key_vault_name = "${local.prefix}-p-pnpg-kv"

  # 🔐 RTD KV Domain
  dev_rtd_key_vault_resource_group  = "${local.prefix}-d-rtd-sec-rg"
  uat_rtd_key_vault_resource_group  = "${local.prefix}-u-rtd-sec-rg"
  prod_rtd_key_vault_resource_group = "${local.prefix}-p-rtd-sec-rg"

  dev_rtd_key_vault_name  = "${local.prefix}-d-rtd-kv"
  uat_rtd_key_vault_name  = "${local.prefix}-u-rtd-kv"
  prod_rtd_key_vault_name = "${local.prefix}-p-rtd-kv"

  # 🔐 TAE KV Domain
  dev_tae_key_vault_resource_group  = "${local.prefix}-d-tae-sec-rg"
  uat_tae_key_vault_resource_group  = "${local.prefix}-u-tae-sec-rg"
  prod_tae_key_vault_resource_group = "${local.prefix}-p-tae-sec-rg"

  dev_tae_key_vault_name  = "${local.prefix}-d-tae-kv"
  uat_tae_key_vault_name  = "${local.prefix}-u-tae-kv"
  prod_tae_key_vault_name = "${local.prefix}-p-tae-kv"
}

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

variable "project_name" {
  type        = string
  description = "Project name for IaC projects"
}


variable "project_iac_name" {
  type        = string
  description = "Project name for IaC projects"
}

variable "terraform_remote_state_core" {
  type = object({
    resource_group_name  = string,
    storage_account_name = string,
    container_name       = string,
    key                  = string
  })
}

variable "aks_dev_platform_name" {
  type        = string
  description = "AKS DEV platform name"
}

variable "aks_uat_platform_name" {
  type        = string
  description = "AKS UAT platform name"
}

variable "aks_prod_platform_name" {
  type        = string
  description = "AKS PROD platform name"
}

variable "service_endpoint_io_azure_devops_github_ro_name" {
  type = string
}

variable "service_endpoint_io_azure_devops_github_rw_name" {
  type = string
}

variable "service_endpoint_io_azure_devops_github_pr_name" {
  type = string
}

variable "service_endpoint_azure_dev_name" {
  type = string
}

variable "service_endpoint_azure_uat_name" {
  type = string
}

variable "service_endpoint_azure_prod_name" {
  type = string
}
