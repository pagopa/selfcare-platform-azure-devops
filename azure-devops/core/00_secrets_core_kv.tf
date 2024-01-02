module "dev_secrets" {

  providers = {
    azurerm = azurerm.dev
  }

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.35.0"

  resource_group = local.dev_key_vault_resource_group
  key_vault_name = local.dev_key_vault_name

  secrets = [
    "dev-selfcare-aks-apiserver-url",
    "dev-selfcare-aks-azure-devops-sa-cacrt",
    "dev-selfcare-aks-azure-devops-sa-token",
  ]
}

module "uat_secrets" {

  providers = {
    azurerm = azurerm.uat
  }

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.35.0"

  resource_group = local.uat_key_vault_resource_group
  key_vault_name = local.uat_key_vault_name

  secrets = [
    "uat-selfcare-aks-apiserver-url",
    "uat-selfcare-aks-azure-devops-sa-cacrt",
    "uat-selfcare-aks-azure-devops-sa-token",
  ]
}

module "prod_secrets" {

  providers = {
    azurerm = azurerm.prod
  }

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.35.0"

  resource_group = local.prod_key_vault_resource_group
  key_vault_name = local.prod_key_vault_name

  secrets = [
    "prod-selfcare-aks-apiserver-url",
    "prod-selfcare-aks-azure-devops-sa-cacrt",
    "prod-selfcare-aks-azure-devops-sa-token",
  ]
}
