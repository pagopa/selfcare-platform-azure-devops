module "tlscert-selc-internal-dev-selfcare-pagopa-it-cert_az" {
  providers = {
    azurerm = azurerm.dev
  }

  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_tls_cert_federated?ref=v6.0.0"

  location   = local.location
  project_id = data.azuredevops_project.project.id

  repository = {
    organization   = local.organization
    name           = local.acme_repository_name
    branch_name    = local.master_branch_ref
    pipelines_path = "."
  }

  path                                 = "${local.selfcare_legacy.pipelines_folder_name}\\TLS-Certificates\\DEV"
  github_service_connection_id         = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id
  managed_identity_resource_group_name = local.dev_resource_group_name

  dns_record_name         = "selc.internal"
  dns_zone_name           = "dev.selfcare.pagopa.it"
  dns_zone_resource_group = local.dev_vnet_resource_group_name
  tenant_id               = module.secrets.values["PAGOPAIT-TENANTID"].value
  subscription_name       = local.dev_selfcare_subscription_name
  subscription_id         = module.secrets.values["PAGOPAIT-DEV-SELFCARE-SUBSCRIPTION-ID"].value

  credential_key_vault_name           = data.azurerm_key_vault.key_vault_dev.name
  credential_key_vault_resource_group = data.azurerm_key_vault.key_vault_dev.resource_group_name

  variables = {
    CERT_NAME_EXPIRE_SECONDS     = "2592000" #30 days
    KEY_VAULT_NAME               = data.azurerm_key_vault.key_vault_dev.name
    KEY_VAULT_SERVICE_CONNECTION = module.DEV-SELFCARE-TLS-CERT-SERVICE-CONN.service_endpoint_name
  }

  variables_secret = {}

  service_connection_ids_authorization = [
    module.DEV-SELFCARE-TLS-CERT-SERVICE-CONN.service_endpoint_id,
  ]
}
