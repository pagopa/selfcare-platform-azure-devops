#
# PROD ECOMMERCE KEYVAULT
#

module "tae_dev_secrets" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

  resource_group = local.dev_tae_key_vault_resource_group
  key_vault_name = local.dev_tae_key_vault_name

  secrets = [
  ]
}

module "tae_uat_secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

  providers = {
    azurerm = azurerm.uat
  }

  resource_group = local.uat_tae_key_vault_resource_group
  key_vault_name = local.uat_tae_key_vault_name

  secrets = [
  ]
}

# module "tae_prod_secrets" {
#   source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.18.9"

#   providers = {
#     azurerm = azurerm.prod
#   }

#   resource_group = local.prod_tae_key_vault_resource_group
#   key_vault_name = local.prod_tae_key_vault_name

#   secrets = [
#     "cstar-p-weu-prod-aks-azure-devops-sa-token",
#     "cstar-p-weu-prod-aks-azure-devops-sa-cacrt",
#     "cstar-p-weu-prod-aks-apiserver-url"
#   ]
# }
