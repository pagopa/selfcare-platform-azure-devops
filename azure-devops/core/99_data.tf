data "azurerm_key_vault" "key_vault_dev" {
  provider = azurerm.dev

  name                = local.dev_key_vault_name
  resource_group_name = local.dev_key_vault_resource_group
}

data "azurerm_key_vault" "key_vault_uat" {
  provider = azurerm.uat

  name                = local.uat_key_vault_name
  resource_group_name = local.uat_key_vault_resource_group
}

data "azurerm_key_vault" "key_vault_prod" {
  provider = azurerm.prod

  name                = local.prod_key_vault_name
  resource_group_name = local.prod_key_vault_resource_group
}
