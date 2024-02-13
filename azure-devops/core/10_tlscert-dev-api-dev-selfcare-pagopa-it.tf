locals {
  tlscert-dev-api-dev-selfcare-pagopa-it = {
    # tenant_id                            = module.secrets.values["PAGOPAIT-TENANTID"].value
    subscription_name                    = "DEV-SelfCare"
    subscription_id                      = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id # module.secrets.values["PAGOPAIT-DEV-SELFCARE-SUBSCRIPTION-ID"].value
    tenant_id                            = data.azurerm_client_config.current.tenant_id
    managed_identity_resource_group_name = "selc-d-identity-rg"
    key_vault_dev                        = "selc-d-kv"
    key_vault_dev_resource_group_name    = "selc-d-sec-rg"

    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }

    pipeline = {
      enable_tls_cert         = true
      path                    = "TLS-Certificates\\DEV"
      dns_record_name         = "api"
      dns_zone_name           = "dev.selfcare.pagopa.it"
      dns_zone_resource_group = "selc-d-vnet-rg"
      # common variables to all pipelines
      variables = {
        CERT_NAME_EXPIRE_SECONDS = "2592000" #30 days
        KEY_VAULT_NAME           = "selc-d-kv"
      }
      # common secret variables to all pipelines
      variables_secret = {
      }
    }
  }
}

module "tlscert-dev-api-dev-selfcare-pagopa-it-cert_az" {
  providers = {
    azurerm = azurerm.dev
  }

  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_tls_cert_federated?ref=v6.0.0"
  # count  = var.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

  location                             = local.location
  project_id                           = data.azuredevops_project.project.id
  repository                           = local.tlscert-dev-api-dev-selfcare-pagopa-it.repository
  path                                 = "${local.selfcare_legacy.pipelines_folder_name}\\${local.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.path}"
  github_service_connection_id         = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id
  managed_identity_resource_group_name = local.tlscert-dev-api-dev-selfcare-pagopa-it.managed_identity_resource_group_name

  dns_record_name         = local.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.dns_record_name
  dns_zone_name           = local.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group = local.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.dns_zone_resource_group
  tenant_id               = local.tlscert-dev-api-dev-selfcare-pagopa-it.tenant_id
  subscription_name       = local.tlscert-dev-api-dev-selfcare-pagopa-it.subscription_name
  subscription_id         = local.tlscert-dev-api-dev-selfcare-pagopa-it.subscription_id

  credential_key_vault_name           = local.tlscert-dev-api-dev-selfcare-pagopa-it.key_vault_dev
  credential_key_vault_resource_group = local.tlscert-dev-api-dev-selfcare-pagopa-it.key_vault_dev_resource_group_name

  variables = merge(
    local.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.variables,
    {
      # KEY_VAULT_CERT_NAME          = "${replace(local.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.dns_record_name, ".", "-")}-${replace(local.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.dns_zone_name, ".", "-")}"
      KEY_VAULT_SERVICE_CONNECTION = module.DEV-SELFCARE-TLS-CERT-SERVICE-CONN.service_endpoint_name
    }
  )

  variables_secret = merge(
    local.tlscert-dev-api-dev-selfcare-pagopa-it.pipeline.variables_secret
  )

  service_connection_ids_authorization = [
    module.DEV-SELFCARE-TLS-CERT-SERVICE-CONN.service_endpoint_id,
  ]
}

resource "azurerm_key_vault_access_policy" "DEV-TLS-CERT-SERVICE-CONN_kv_dev" {
  provider = azurerm.dev

  key_vault_id = data.azurerm_key_vault.key_vault_dev.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.DEV-SELFCARE-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

data "azurerm_key_vault" "key_vault_dev" {
  provider            = azurerm.dev
  name                = local.dev_key_vault_name
  resource_group_name = local.dev_key_vault_resource_group
}
