#
# PROD ECOMMERCE KEYVAULT
#

module "rtd_dev_secrets" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

  resource_group = local.dev_rtd_key_vault_resource_group
  key_vault_name = local.dev_rtd_key_vault_name

  secrets = [
    "cstar-d-weu-dev01-aks-apiserver-url",
    "cstar-d-weu-dev01-aks-azure-devops-sa-token",
    "cstar-d-weu-dev01-aks-azure-devops-sa-cacrt",
  ]
}

module "rtd_uat_secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

  providers = {
    azurerm = azurerm.uat
  }

  resource_group = local.uat_rtd_key_vault_resource_group
  key_vault_name = local.uat_rtd_key_vault_name

  secrets = [
    "cstar-u-weu-uat01-aks-azure-devops-sa-token",
    "cstar-u-weu-uat01-aks-azure-devops-sa-cacrt",
    "cstar-u-weu-uat01-aks-apiserver-url"
  ]
}

# module "rtd_prod_secrets" {
#   source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

#   providers = {
#     azurerm = azurerm.prod
#   }

#   resource_group = local.prod_rtd_key_vault_resource_group
#   key_vault_name = local.prod_rtd_key_vault_name

#   secrets = [
#     "cstar-p-weu-prod-aks-azure-devops-sa-token",
#     "cstar-p-weu-prod-aks-azure-devops-sa-cacrt",
#     "cstar-p-weu-prod-aks-apiserver-url"
#   ]
# }
