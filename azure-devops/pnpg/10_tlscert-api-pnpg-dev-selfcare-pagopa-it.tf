variable "tlscert-api-pnpg-dev-selfcare-pagopa-it" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }
    pipeline = {
      enable_tls_cert = true
      path            = "TLS-Certificates\\DEV"
      dns_record_name         = "api-pnpg"
      dns_zone_name           = "dev.selfcare.pagopa.it"
      # dns_zone_resource_group = "selc-d-vnet-rg"
      # common variables to all pipelines
      variables = {
        CERT_NAME_EXPIRE_SECONDS = "2592000" #30 days
      }
      # common secret variables to all pipelines
      variables_secret = {
      }
    }
  }
}

locals {
  tlscert-api-pnpg-dev-selfcare-pagopa-it = {
    tenant_id                           = module.secrets_core_prod.values["PAGOPAIT-TENANTID"].value
    subscription_name                   = local.dev_selc_subscription_name
    subscription_id                     = module.secrets_core_prod.values["PAGOPAIT-DEV-SELFCARE-SUBSCRIPTION-ID"].value
    dns_zone_resource_group             = local.rg_dev_dns_zone_name
    credential_subcription              = local.dev_selc_subscription_name
    credential_key_vault_name           = local.dev_domain_key_vault_name
    credential_key_vault_resource_group = local.dev_domain_key_vault_resource_group
    service_connection_ids_authorization = [
      module.DEV-SELC-PNPG-TLS-CERT-SERVICE-CONN.service_endpoint_id,
    ]
  }
  tlscert-api-pnpg-dev-selfcare-pagopa-it-variables = {
    KEY_VAULT_SERVICE_CONNECTION = module.DEV-SELC-PNPG-TLS-CERT-SERVICE-CONN.service_endpoint_name,
    KEY_VAULT_NAME               = local.dev_domain_key_vault_name
  }
  tlscert-api-pnpg-dev-selfcare-pagopa-it-variables_secret = {
  }
}

# change only providers
#tfsec:ignore:general-secrets-no-plaintext-exposure
module "tlscert-api-pnpg-dev-selfcare-pagopa-it-cert_az" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert?ref=v2.6.5"
  count  = var.tlscert-api-pnpg-dev-selfcare-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

  # change me
  providers = {
    azurerm = azurerm.dev
  }

  project_id = data.azuredevops_project.project.id
  repository = var.tlscert-api-pnpg-dev-selfcare-pagopa-it.repository
  name       = "${var.tlscert-api-pnpg-dev-selfcare-pagopa-it.pipeline.dns_record_name}.${var.tlscert-api-pnpg-dev-selfcare-pagopa-it.pipeline.dns_zone_name}"
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN003
  renew_token                  = local.tlscert_renew_token
  path                         = "${local.domain}\\${var.tlscert-api-pnpg-dev-selfcare-pagopa-it.pipeline.path}"
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id

  dns_record_name         = var.tlscert-api-pnpg-dev-selfcare-pagopa-it.pipeline.dns_record_name
  dns_zone_name           = var.tlscert-api-pnpg-dev-selfcare-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group = local.tlscert-api-pnpg-dev-selfcare-pagopa-it.dns_zone_resource_group
  tenant_id               = local.tlscert-api-pnpg-dev-selfcare-pagopa-it.tenant_id
  subscription_name       = local.tlscert-api-pnpg-dev-selfcare-pagopa-it.subscription_name
  subscription_id         = local.tlscert-api-pnpg-dev-selfcare-pagopa-it.subscription_id

  credential_subcription              = local.tlscert-api-pnpg-dev-selfcare-pagopa-it.credential_subcription
  credential_key_vault_name           = local.tlscert-api-pnpg-dev-selfcare-pagopa-it.credential_key_vault_name
  credential_key_vault_resource_group = local.tlscert-api-pnpg-dev-selfcare-pagopa-it.credential_key_vault_resource_group

  variables = merge(
    var.tlscert-api-pnpg-dev-selfcare-pagopa-it.pipeline.variables,
    local.tlscert-api-pnpg-dev-selfcare-pagopa-it-variables,
  )

  variables_secret = merge(
    var.tlscert-api-pnpg-dev-selfcare-pagopa-it.pipeline.variables_secret,
    local.tlscert-api-pnpg-dev-selfcare-pagopa-it-variables_secret,
  )

  service_connection_ids_authorization = local.tlscert-api-pnpg-dev-selfcare-pagopa-it.service_connection_ids_authorization

  schedules = {
    days_to_build              = ["Mon"]
    schedule_only_with_changes = false
    start_hours                = 3
    start_minutes              = 0
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = [var.tlscert-api-pnpg-dev-selfcare-pagopa-it.repository.branch_name]
      exclude = []
    }
  }

  depends_on = [
    module.letsencrypt_dev
  ]
}
