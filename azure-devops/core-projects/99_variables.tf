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
  description = "Project name project"
}

locals {
  project_prefix_short = "cstar"
  domain               = "core"
  azure_devops_org     = "pagopaspa"

  # Subscription
  dev_subscription_name  = "dev-cstar"
  uat_subscription_name  = "uat-cstar"
  prod_subscription_name = "prod-cstar"


  # 🔐 KV
  prod_key_vault_azdo_name = "${local.project_prefix_short}-p-azdo-weu-kv"

  dev_domain_key_vault_name  = "${local.project_prefix_short}-d-kv"
  uat_domain_key_vault_name  = "${local.project_prefix_short}-u-kv"
  prod_domain_key_vault_name = "${local.project_prefix_short}-p-kv"

  dev_domain_key_vault_resource_group  = "${local.project_prefix_short}-d-sec-rg"
  uat_domain_key_vault_resource_group  = "${local.project_prefix_short}-u-sec-rg"
  prod_domain_key_vault_resource_group = "${local.project_prefix_short}-p-sec-rg"

  # ☁️ VNET
  dev_vnet_rg  = "${local.project_prefix_short}-d-vnet-rg"
  uat_vnet_rg  = "${local.project_prefix_short}-u-vnet-rg"
  prod_vnet_rg = "${local.project_prefix_short}-p-vnet-rg"

  # DNS Zone

  rg_dev_dns_zone_name  = "cstar-d-vnet-rg"
  rg_uat_dns_zone_name  = "cstar-u-vnet-rg"
  rg_prod_dns_zone_name = "cstar-p-vnet-rg"

  dev_dns_zone_name  = "dev.cstar.pagopa.it"
  uat_dns_zone_name  = "uat.cstar.pagopa.it"
  prod_dns_zone_name = "cstar.pagopa.it"

  # 📦 ACR DEV DOCKER
  srv_endpoint_name_docker_registry_dev = "cstar-azurecrcommon-dev"
  docker_registry_rg_name_dev           = "cstar-d-container-registry-rg"
  docker_registry_name_dev              = "cstardcommonacr"

  # 📦 ACR UAT DOCKER
  srv_endpoint_name_docker_registry_uat = "cstar-azurecrcommon-uat"
  docker_registry_rg_name_uat           = "cstar-u-container-registry-rg"
  docker_registry_name_uat              = "cstarucommonacr"

  # 📦 ACR PROD DOCKER
  srv_endpoint_name_docker_registry_prod = "cstar-azurecrcommon-prod"
  docker_registry_rg_name_prod           = "cstar-p-container-registry-rg"
  docker_registry_name_prod              = "cstarpcommonacr"

  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN002
  tlscert_renew_token = "v1"

  ### SONAR
  azuredevops_serviceendpoint_sonarcloud_id = "1a9c808a-84ca-4d0c-8d5a-1976a1ae685f"

  #
  # APP insights
  #
  appinsights_renew_token = "v1"

  dev_appinsights_name           = "${local.project_prefix_short}-d-appinsights"
  dev_appinsights_resource_group = "${local.project_prefix_short}-d-monitor-rg"

  uat_appinsights_name           = "${local.project_prefix_short}-u-appinsights"
  uat_appinsights_resource_group = "${local.project_prefix_short}-u-monitor-rg"

  prod_appinsights_name           = "${local.project_prefix_short}-p-appinsights"
  prod_appinsights_resource_group = "${local.project_prefix_short}-p-monitor-rg"
}
