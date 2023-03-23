#
# PROD ECOMMERCE KEYVAULT
#

module "idpay_dev_secrets" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

  resource_group = local.dev_idpay_key_vault_resource_group
  key_vault_name = local.dev_idpay_key_vault_name

  secrets = [
    "selc-d-weu-dev01-aks-apiserver-url",
    "selc-d-weu-dev01-aks-azure-devops-sa-token",
    "selc-d-weu-dev01-aks-azure-devops-sa-cacrt",
  ]
}

module "idpay_uat_secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

  providers = {
    azurerm = azurerm.uat
  }

  resource_group = local.uat_idpay_key_vault_resource_group
  key_vault_name = local.uat_idpay_key_vault_name

  secrets = [
    "selc-u-weu-uat01-aks-azure-devops-sa-token",
    "selc-u-weu-uat01-aks-azure-devops-sa-cacrt",
    "selc-u-weu-uat01-aks-apiserver-url"
  ]
}

module "idpay_prod_secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

  providers = {
    azurerm = azurerm.prod
  }

  resource_group = local.prod_idpay_key_vault_resource_group
  key_vault_name = local.prod_idpay_key_vault_name

  secrets = [
    "selc-p-weu-prod01-aks-azure-devops-sa-token",
    "selc-p-weu-prod01-aks-azure-devops-sa-cacrt",
    "selc-p-weu-prod01-aks-apiserver-url"
  ]
}
