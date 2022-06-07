#
# Subscription
#

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
  description = "Project name (e.g. pagoPA platform)"
}

variable "terraform_remote_state_core" {
  type = object({
    resource_group_name  = string,
    storage_account_name = string,
    container_name       = string,
    key                  = string
  })
}

locals {
  prefix           = "cstar"
  azure_devops_org = "pagopaspa"
  domain           = "idpay"

  # 🔐 KV
  dev_key_vault_azdo_name  = "${local.prefix}-d-azdo-weu-kv"
  uat_key_vault_azdo_name  = "${local.prefix}-u-azdo-weu-kv"
  prod_key_vault_azdo_name = "${local.prefix}-p-azdo-weu-kv"

  dev_idpay_key_vault_name  = "${local.prefix}-d-${local.domain}-kv"
  uat_idpay_key_vault_name  = "${local.prefix}-u-${local.domain}-kv"
  prod_idpay_key_vault_name = "${local.prefix}-p-${local.domain}-kv"

  # 📦 Resource group
  dev_key_vault_resource_group  = "${local.prefix}-d-sec-rg"
  uat_key_vault_resource_group  = "${local.prefix}-u-sec-rg"
  prod_key_vault_resource_group = "${local.prefix}-p-sec-rg"

  dev_idpay_key_vault_resource_group  = "${local.prefix}-d-${local.domain}-sec-rg"
  uat_idpay_key_vault_resource_group  = "${local.prefix}-u-${local.domain}-sec-rg"
  prod_idpay_key_vault_resource_group = "${local.prefix}-p-${local.domain}-sec-rg"

  # ☁️ VNET
  dev_vnet_rg  = "${local.prefix}-d-vnet-rg"
  uat_vnet_rg  = "${local.prefix}-u-vnet-rg"
  prod_vnet_rg = "${local.prefix}-p-vnet-rg"

  # 📦 ACR DEV FOR AKS
  srv_endpoint_name_aks_cr_dev = "${local.prefix}-aks-cr-dev"
  aks_cr_rg_name_dev           = "${local.prefix}-d-container-registry-rg"
  aks_cr_name_dev              = "${local.prefix}dcommonacr"

  # 📦 ACR UAT FOR AKS
  srv_endpoint_name_aks_cr_uat = "${local.prefix}-aks-cr-uat"
  aks_cr_rg_name_uat           = "${local.prefix}-u-container-registry-rg"
  aks_cr_name_uat              = "${local.prefix}ucommonacr"

  # 📦 ACR PROD FOR AKS
  srv_endpoint_name_aks_cr_prod = "${local.prefix}-aks-cr-prod"
  aks_cr_rg_name_prod           = "${local.prefix}-p-container-registry-rg"
  aks_cr_name_prod              = "${local.prefix}pcommonacr"

  # AKS
  srv_endpoint_name_aks_dev  = "${local.prefix}-${local.domain}-aks-dev"
  srv_endpoint_name_aks_uat  = "${local.prefix}-${local.domain}-aks-uat"
  srv_endpoint_name_aks_prod = "${local.prefix}-${local.domain}-aks-prod"

  # Agent Pool
  azdo_agent_pool_dev = "cstar-dev-linux"
  azdo_agent_pool_uat = "cstar-uat-linux"
  azdo_agent_pool_prod = "cstar-prod-linux"

  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN002
  tlscert_renew_token = "v1"

  # TODO azure devops terraform provider does not support SonarCloud service endpoint
  azuredevops_serviceendpoint_sonarcloud_id = "9182be64-d387-465d-9acc-e79e802910c8"

  #
  # Outputs from CORE
  #
  service_endpoint_io_azure_devops_github_ro_name = data.terraform_remote_state.core.outputs.service_endpoint_io_azure_devops_github_ro_name
  service_endpoint_io_azure_devops_github_pr_id = data.terraform_remote_state.core.outputs.service_endpoint_io_azure_devops_github_pr_id
  service_endpoint_io_azure_devops_github_ro_id = data.terraform_remote_state.core.outputs.service_endpoint_io_azure_devops_github_ro_id
  
  service_endpoint_azure_devops_acr_aks_dev_name = data.terraform_remote_state.core.outputs.service_endpoint_azure_devops_acr_aks_dev_name
  service_endpoint_azure_devops_acr_aks_dev_id = data.terraform_remote_state.core.outputs.service_endpoint_azure_devops_acr_aks_dev_id

  service_endpoint_azure_dev_id = data.terraform_remote_state.core.outputs.service_endpoint_azure_dev_id
}
