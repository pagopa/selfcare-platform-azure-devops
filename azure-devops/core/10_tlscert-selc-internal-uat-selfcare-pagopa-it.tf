variable "tlscert-selc-internal-uat-selfcare-pagopa-it" {
  default = {
    repository = {
      organization   = "pagopa"
      name           = "le-azure-acme-tiny"
      branch_name    = "refs/heads/master"
      pipelines_path = "."
    }
    pipeline = {
      enable_tls_cert         = true
      path                    = "TLS-Certificates\\UAT"
      dns_record_name         = "selc.internal"
      dns_zone_name           = "uat.selfcare.pagopa.it"
      dns_zone_resource_group = "selc-u-vnet-rg"
      # common variables to all pipelines
      variables = {
        CERT_NAME_EXPIRE_SECONDS = "2592000" #30 days
        KEY_VAULT_NAME           = "selc-u-kv"
      }
      # common secret variables to all pipelines
      variables_secret = {
      }
    }
  }
}

locals {
  tlscert-selc-internal-uat-selfcare-pagopa-it = {
    tenant_id         = module.secrets.values["PAGOPAIT-TENANTID"].value
    subscription_name = "UAT-SelfCare"
    subscription_id   = module.secrets.values["PAGOPAIT-UAT-SELFCARE-SUBSCRIPTION-ID"].value
  }
  tlscert-selc-internal-uat-selfcare-pagopa-it-variables = {
    KEY_VAULT_CERT_NAME          = "${replace(var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.dns_record_name, ".", "-")}-${replace(var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.dns_zone_name, ".", "-")}"
    KEY_VAULT_SERVICE_CONNECTION = module.UAT-SELFCARE-TLS-CERT-SERVICE-CONN.service_endpoint_name
  }
  tlscert-selc-internal-uat-selfcare-pagopa-it-variables_secret = {
  }
}

module "tlscert-selc-internal-uat-selfcare-pagopa-it-cert_az" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_tls_cert?ref=v4.1.1"
  count  = var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.enable_tls_cert == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.tlscert-selc-internal-uat-selfcare-pagopa-it.repository
  name                         = "${var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.dns_record_name}.${var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.dns_zone_name}"
  path                         = "${local.selfcare_legacy.pipelines_folder_name}\\${var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.path}"
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id
  #tfsec:ignore:GEN003
  renew_token = local.tlscert_renew_token

  dns_record_name         = var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.dns_record_name
  dns_zone_name           = var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.dns_zone_name
  dns_zone_resource_group = var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.dns_zone_resource_group
  tenant_id               = local.tlscert-selc-internal-uat-selfcare-pagopa-it.tenant_id
  subscription_name       = local.tlscert-selc-internal-uat-selfcare-pagopa-it.subscription_name
  subscription_id         = local.tlscert-selc-internal-uat-selfcare-pagopa-it.subscription_id

  credential_subcription              = local.core_key_vault_subscription_name
  credential_key_vault_name           = local.core_key_vault_name
  credential_key_vault_resource_group = local.core_key_vault_resource_group

  variables = merge(
    var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.variables,
    local.tlscert-selc-internal-uat-selfcare-pagopa-it-variables,
  )

  variables_secret = merge(
    var.tlscert-selc-internal-uat-selfcare-pagopa-it.pipeline.variables_secret,
    local.tlscert-selc-internal-uat-selfcare-pagopa-it-variables_secret,
  )

  service_connection_ids_authorization = [
    module.UAT-SELFCARE-TLS-CERT-SERVICE-CONN.service_endpoint_id,
  ]

  schedules = {
    days_to_build              = ["Fri"]
    schedule_only_with_changes = false
    start_hours                = 7
    start_minutes              = 0
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = ["master"]
      exclude = []
    }
  }
}
