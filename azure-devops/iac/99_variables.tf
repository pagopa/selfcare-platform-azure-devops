locals {
  project_prefix_short = "selc"
  azure_devops_org     = "pagopaspa"
  github_org           = "pagopa"
  prefix               = "selc"

  # 🔐 KV AZDO
  prod_key_vault_resource_group = "${local.project_prefix_short}-p-sec-rg"

  prod_key_vault_azdo_name = "${local.project_prefix_short}-p-azdo-weu-kv"

  # 🔐 IDPAY KV Domain
  dev_idpay_key_vault_resource_group  = "${local.prefix}-d-idpay-sec-rg"
  uat_idpay_key_vault_resource_group  = "${local.prefix}-u-idpay-sec-rg"
  prod_idpay_key_vault_resource_group = "${local.prefix}-p-idpay-sec-rg"

  dev_idpay_key_vault_name  = "${local.prefix}-d-idpay-kv"
  uat_idpay_key_vault_name  = "${local.prefix}-u-idpay-kv"
  prod_idpay_key_vault_name = "${local.prefix}-p-idpay-kv"

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

variable "project_iac_name" {
  type        = string
  description = "Project name for IaC projects"
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
