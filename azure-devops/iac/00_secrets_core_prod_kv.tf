module "secrets_core_prod" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v2.0.4"

  resource_group = local.prod_key_vault_resource_group
  key_vault_name = local.prod_key_vault_azdo_name

  secrets = [
    "io-azure-devops-github-ro-TOKEN",
    "io-azure-devops-github-pr-TOKEN",
    "io-azure-devops-github-rw-TOKEN",
    "io-azure-devops-github-EMAIL",
    "io-azure-devops-github-USERNAME",
    "PAGOPAIT-TENANTID",
    "PAGOPAIT-DEV-SELFCARE-SUBSCRIPTION-ID",
    "PAGOPAIT-UAT-SELFCARE-SUBSCRIPTION-ID",
    "PAGOPAIT-PROD-SELFCARE-SUBSCRIPTION-ID",
  ]
}
