#
# PROD ECOMMERCE KEYVAULT
#

module "domain_dev_secrets" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.4"

  resource_group = local.dev_domain_key_vault_resource_group
  key_vault_name = local.dev_domain_key_vault_name

  secrets = [
    "cstar-d-weu-dev01-aks-apiserver-url",
    "cstar-d-weu-dev01-aks-azure-devops-sa-token",
    "cstar-d-weu-dev01-aks-azure-devops-sa-cacrt",
  ]
}

# module "domain_uat_secrets" {
#   source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.4"

#   resource_group = local.uat_domain_key_vault_resource_group
#   key_vault_name = local.uat_domain_key_vault_name

#   secrets = [
#     "pagopa-u-weu-dev-aks-azure-devops-sa-token",
#     "pagopa-u-weu-dev-aks-azure-devops-sa-cacrt",
#     "pagopa-u-weu-dev-aks-apiserver-url"
#   ]
# }

# module "domain_prod_secrets" {
#   source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.4"

#   resource_group = local.prod_domain_key_vault_resource_group
#   key_vault_name = local.prod_domain_key_vault_name

#   secrets = [
#     "pagopa-p-weu-dev-aks-azure-devops-sa-token",
#     "pagopa-p-weu-dev-aks-azure-devops-sa-cacrt",
#     "pagopa-p-weu-dev-aks-apiserver-url"
#   ]
# }
