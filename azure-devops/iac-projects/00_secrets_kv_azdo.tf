module "secret_azdo" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.4.0"

  resource_group = local.prod_key_vault_resource_group
  key_vault_name = local.prod_key_vault_azdo_name

  secrets = [
    "selc-azure-devops-github-ro-TOKEN",
    "selc-azure-devops-github-pr-TOKEN",
    "selc-azure-devops-github-rw-TOKEN",
    "PAGOPAIT-TENANTID",
    "PAGOPAIT-DEV-SELC-SUBSCRIPTION-ID",
    "PAGOPAIT-UAT-SELC-SUBSCRIPTION-ID",
    "PAGOPAIT-PROD-SELC-SUBSCRIPTION-ID",
  ]
}
