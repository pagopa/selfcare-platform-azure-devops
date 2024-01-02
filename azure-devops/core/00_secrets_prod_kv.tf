module "secrets" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault_secrets_query?ref=v7.35.0"

  key_vault_name = local.core_key_vault_name
  resource_group = local.core_key_vault_resource_group

  secrets = [
    "io-azure-devops-github-ro-TOKEN",
    "io-azure-devops-github-rw-TOKEN",
    "io-azure-devops-github-pr-TOKEN",
    "io-azure-devops-github-EMAIL",
    "io-azure-devops-github-USERNAME",
    "pagopa-npm-bot-TOKEN",
    "PAGOPAIT-TENANTID",
    "PAGOPAIT-DEV-SELFCARE-SUBSCRIPTION-ID",
    "PAGOPAIT-UAT-SELFCARE-SUBSCRIPTION-ID",
    "PAGOPAIT-PROD-SELFCARE-SUBSCRIPTION-ID",
    "SELC-DOCKER-REGISTRY-PAGOPA-USER",
    "SELC-DOCKER-REGISTRY-PAGOPA-TOKEN-RO",
  ]
}
