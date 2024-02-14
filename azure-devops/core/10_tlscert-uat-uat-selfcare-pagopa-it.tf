module "tlscert-uat-uat-selfcare-pagopa-it-cert_az" {
  providers = {
    azurerm = azurerm.uat
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

  path                                 = "${local.selfcare_legacy.pipelines_folder_name}\\TLS-Certificates\\UAT"
  github_service_connection_id         = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id
  managed_identity_resource_group_name = local.uat_resource_group_name

  dns_record_name         = ""
  dns_zone_name           = "uat.selfcare.pagopa.it"
  dns_zone_resource_group = local.uat_vnet_resource_group_name
  tenant_id               = module.secrets.values["PAGOPAIT-TENANTID"].value
  subscription_name       = local.uat_selfcare_subscription_name
  subscription_id         = module.secrets.values["PAGOPAIT-UAT-SELFCARE-SUBSCRIPTION-ID"].value

  credential_key_vault_name           = data.azurerm_key_vault.key_vault_uat.name
  credential_key_vault_resource_group = data.azurerm_key_vault.key_vault_uat.resource_group_name

  variables = {
    CERT_NAME_EXPIRE_SECONDS     = "2592000" #30 days
    KEY_VAULT_NAME               = data.azurerm_key_vault.key_vault_uat.name
    KEY_VAULT_SERVICE_CONNECTION = module.UAT-SELFCARE-TLS-CERT-SERVICE-CONN.service_endpoint_name
  }

  variables_secret = {}

  service_connection_ids_authorization = [
    module.UAT-SELFCARE-TLS-CERT-SERVICE-CONN.service_endpoint_id,
  ]
}
