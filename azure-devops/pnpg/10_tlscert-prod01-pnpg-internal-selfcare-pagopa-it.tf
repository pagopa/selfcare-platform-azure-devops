variable "tlscert-prod01-pnpg-internal-selc-pagopa-it" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }
    pipeline = {
      enable_tls_cert = true
      path            = "TLS-Certificates\\PROD"
      dns_record_name = "prod01.pnpg.internal"
      dns_zone_name   = "selfcare.pagopa.it"
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
  tlscert-prod01-pnpg-internal-selc-pagopa-it = {
    tenant_id                           = module.secrets_core_prod.values["PAGOPAIT-TENANTID"].value
    subscription_name                   = local.prod_selc_subscription_name
    subscription_id                     = module.secrets_core_prod.values["PAGOPAIT-PROD-SELFCARE-SUBSCRIPTION-ID"].value
    dns_zone_resource_group             = local.rg_prod_dns_zone_name
    credential_subcription              = local.prod_selc_subscription_name
    credential_key_vault_name           = local.prod_domain_key_vault_name
    credential_key_vault_resource_group = local.prod_domain_key_vault_resource_group
    service_connection_ids_authorization = [
      module.PROD-SELC-PNPG-TLS-CERT-SERVICE-CONN.service_endpoint_id,
    ]
  }
  tlscert-prod01-pnpg-internal-selc-pagopa-it-variables = {
    KEY_VAULT_SERVICE_CONNECTION = module.PROD-SELC-PNPG-TLS-CERT-SERVICE-CONN.service_endpoint_name,
    KEY_VAULT_NAME               = local.prod_domain_key_vault_name
  }
  tlscert-prod01-pnpg-internal-selc-pagopa-it-variables_secret = {
  }
}

# change only providers
#tfsec:ignore:general-secrets-no-plaintext-exposure
module "tlscert-prod01-pnpg-internal-selc-pagopa-it-cert_az" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert?ref=v2.6.5"
  count  = var.tlscert-prod01-pnpg-internal-selc-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

  # change me
  providers = {
    azurerm = azurerm.prod
  }

  project_id = data.azuredevops_project.project.id
  repository = var.tlscert-prod01-pnpg-internal-selc-pagopa-it.repository
  name       = "${var.tlscert-prod01-pnpg-internal-selc-pagopa-it.pipeline.dns_record_name}.${var.tlscert-prod01-pnpg-internal-selc-pagopa-it.pipeline.dns_zone_name}"
  #tfsec:ignore:general-secrets-no-plaintext-exposure
  #tfsec:ignore:GEN003
  renew_token                  = local.tlscert_renew_token
  path                         = "${local.domain}\\${var.tlscert-prod01-pnpg-internal-selc-pagopa-it.pipeline.path}"
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id

  dns_record_name         = var.tlscert-prod01-pnpg-internal-selc-pagopa-it.pipeline.dns_record_name
  dns_zone_name           = var.tlscert-prod01-pnpg-internal-selc-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group = local.tlscert-prod01-pnpg-internal-selc-pagopa-it.dns_zone_resource_group
  tenant_id               = local.tlscert-prod01-pnpg-internal-selc-pagopa-it.tenant_id
  subscription_name       = local.tlscert-prod01-pnpg-internal-selc-pagopa-it.subscription_name
  subscription_id         = local.tlscert-prod01-pnpg-internal-selc-pagopa-it.subscription_id

  credential_subcription              = local.tlscert-prod01-pnpg-internal-selc-pagopa-it.credential_subcription
  credential_key_vault_name           = local.tlscert-prod01-pnpg-internal-selc-pagopa-it.credential_key_vault_name
  credential_key_vault_resource_group = local.tlscert-prod01-pnpg-internal-selc-pagopa-it.credential_key_vault_resource_group

  variables = merge(
    var.tlscert-prod01-pnpg-internal-selc-pagopa-it.pipeline.variables,
    local.tlscert-prod01-pnpg-internal-selc-pagopa-it-variables,
  )

  variables_secret = merge(
    var.tlscert-prod01-pnpg-internal-selc-pagopa-it.pipeline.variables_secret,
    local.tlscert-prod01-pnpg-internal-selc-pagopa-it-variables_secret,
  )

  service_connection_ids_authorization = local.tlscert-prod01-pnpg-internal-selc-pagopa-it.service_connection_ids_authorization

  schedules = {
    days_to_build              = ["Mon"]
    schedule_only_with_changes = false
    start_hours                = 3
    start_minutes              = 0
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = [var.tlscert-prod01-pnpg-internal-selc-pagopa-it.repository.branch_name]
      exclude = []
    }
  }

  depends_on = [
    module.letsencrypt_prod
  ]
}
