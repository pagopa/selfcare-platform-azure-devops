#
# PROD ECOMMERCE KEYVAULT
#

module "selfcare_dev_secrets" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v4.13.0"

  resource_group = local.dev_selfcare_pnpg_key_vault_resource_group
  key_vault_name = local.dev_selfcare_pnpg_key_vault_name

  secrets = [
    "selc-d-weu-dev01-aks-apiserver-url",
    "selc-d-weu-dev01-aks-azure-devops-sa-token",
    "selc-d-weu-dev01-aks-azure-devops-sa-cacrt",
  ]
}

module "selfcare_uat_secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v4.13.0"

  providers = {
    azurerm = azurerm.uat
  }

  resource_group = local.uat_selfcare_pnpg_key_vault_resource_group
  key_vault_name = local.uat_selfcare_pnpg_key_vault_name

  secrets = [
    "selc-u-weu-uat01-aks-azure-devops-sa-token",
    "selc-u-weu-uat01-aks-azure-devops-sa-cacrt",
    "selc-u-weu-uat01-aks-apiserver-url"
  ]
}

module "selfcare_prod_secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v4.13.0"

  providers = {
    azurerm = azurerm.prod
  }

  resource_group = local.prod_selfcare_pnpg_key_vault_resource_group
  key_vault_name = local.prod_selfcare_pnpg_key_vault_name

  secrets = [
    "selc-p-weu-prod01-aks-azure-devops-sa-token",
    "selc-p-weu-prod01-aks-azure-devops-sa-cacrt",
    "selc-p-weu-prod01-aks-apiserver-url"
  ]
}
