data "azurerm_key_vault" "key_vault_dev" {
  provider = azurerm.dev

  name                = local.dev_key_vault_name
  resource_group_name = local.dev_key_vault_resource_group
}
