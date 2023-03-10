locals {

  prefix           = "selc"
  azure_devops_org = "pagopaspa"
  domain           = "pnpg"

  #CORE
  core_key_vault_name              = "selc-p-kv"
  core_key_vault_resource_group    = "selc-p-sec-rg"
  core_key_vault_subscription_name = "PROD-SELFCARE"

  # 🔐 KV AZDO
  dev_key_vault_resource_group  = "${local.prefix}-d-pnpg-sec-rg"
  uat_key_vault_resource_group  = "${local.prefix}-u-pnpg-sec-rg"
  prod_key_vault_resource_group = "${local.prefix}-p-pnpg-sec-rg"

  dev_key_vault_azdo_name  = "${local.prefix}-d-azdo-weu-kv"
  uat_key_vault_azdo_name  = "${local.prefix}-u-azdo-weu-kv"
  prod_key_vault_azdo_name = "${local.prefix}-p-azdo-weu-kv"

  # 🔐 KV Domain
  dev_domain_key_vault_resource_group  = "${local.prefix}-d-${local.domain}-sec-rg"
  uat_domain_key_vault_resource_group  = "${local.prefix}-u-${local.domain}-sec-rg"
  prod_domain_key_vault_resource_group = "${local.prefix}-p-${local.domain}-sec-rg"

  dev_domain_key_vault_name  = "${local.prefix}-d-${local.domain}-kv"
  uat_domain_key_vault_name  = "${local.prefix}-u-${local.domain}-kv"
  prod_domain_key_vault_name = "${local.prefix}-p-${local.domain}-kv"

  # ☁️ VNET
  dev_vnet_rg  = "${local.prefix}-d-vnet-rg"
  uat_vnet_rg  = "${local.prefix}-u-vnet-rg"
  prod_vnet_rg = "${local.prefix}-p-vnet-rg"

  # DNS Zone

  rg_dev_dns_zone_name  = "selc-d-vnet-rg"
  rg_uat_dns_zone_name  = "selc-u-vnet-rg"
  rg_prod_dns_zone_name = "selc-p-vnet-rg"

  dev_dns_zone_name  = "dev.selfcare.pagopa.it"
  uat_dns_zone_name  = "uat.selfcare.pagopa.it"
  prod_dns_zone_name = "selfcare.pagopa.it"

  # 📦 ACR DEV FOR AKS
  aks_dev_docker_registry_rg_name = "${local.prefix}-d-container-registry-rg"
  aks_dev_docker_registry_name    = "${local.prefix}dcommonacr"

  # 📦 ACR UAT FOR AKS
  aks_uat_docker_registry_rg_name = "${local.prefix}-u-container-registry-rg"
  aks_uat_docker_registry_name    = "${local.prefix}ucommonacr"

  # 📦 ACR PROD FOR AKS
  aks_docker_rg_name_prod       = "${local.prefix}-p-container-registry-rg"
  aks_prod_docker_registry_name = "${local.prefix}pcommonacr"

  # AKS
  srv_endpoint_name_aks_dev  = "${local.prefix}-${local.domain}-aks-dev"
  srv_endpoint_name_aks_uat  = "${local.prefix}-${local.domain}-aks-uat"
  srv_endpoint_name_aks_prod = "${local.prefix}-${local.domain}-aks-prod"

  # Agent Pool
  azdo_agent_pool_dev  = "selfcare-dev-linux"
  azdo_agent_pool_uat  = "selfcare-uat-linux"
  azdo_agent_pool_prod = "selfcare-prod-linux"

  # Subscription Name
  dev_selc_subscription_name  = "dev-selfcare"
  uat_selc_subscription_name  = "uat-selfcare"
  prod_selc_subscription_name = "prod-selfcare"

  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN002
  tlscert_renew_token = "v2"

  # TODO azure devops terraform provider does not support SonarCloud service endpoint
  azuredevops_serviceendpoint_sonarcloud_id = data.terraform_remote_state.core.outputs.service_connection_sonar_cloud_id

  # DEV
  service_endpoint_azure_devops_docker_dev_name = "selc-docker-common-dev"
  service_endpoint_azure_devops_docker_dev_id   = data.terraform_remote_state.core.outputs.service_connection_docker_registry_common_dev_id

  # UAT
  service_endpoint_azure_devops_docker_uat_name = "selc-docker-common-uat"
  service_endpoint_azure_devops_docker_uat_id   = data.terraform_remote_state.core.outputs.service_connection_docker_registry_common_uat_id

  # PROD
  service_endpoint_azure_devops_docker_prod_name = "selc-docker-common-prod"
  service_endpoint_azure_devops_docker_prod_id   = data.terraform_remote_state.core.outputs.service_connection_docker_registry_common_prod_id

  service_connection_npm_id = data.terraform_remote_state.core.outputs.service_connection_npm_id
  service_connection_npm_endpoint_name = data.terraform_remote_state.core.outputs.service_connection_npm_name
  
}

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
