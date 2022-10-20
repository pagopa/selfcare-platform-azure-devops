#
# DEV
#
module "DEV-CSTAR-CORE-TLS-CERT-SERVICE-CONN" {

  providers = {
    azurerm = azurerm.dev
  }

  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v2.1.0"

  project_id        = data.azuredevops_project.project.id
  name              = "${local.project_prefix_short}-d-${local.domain}-tls-cert"
  tenant_id         = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  subscription_name = local.dev_subscription_name
  subscription_id   = module.secret_azdo.values["PAGOPAIT-DEV-CSTAR-SUBSCRIPTION-ID"].value
  #tfsec:ignore:GEN003
  renew_token = local.tlscert_renew_token

  credential_subcription              = local.dev_subscription_name
  credential_key_vault_name           = local.dev_domain_key_vault_name
  credential_key_vault_resource_group = local.dev_domain_key_vault_resource_group
}

resource "azurerm_key_vault_access_policy" "DEV-CSTAR-CORE-TLS-CERT-SERVICE-CONN_kv_access_policy" {
  provider     = azurerm.dev
  key_vault_id = data.azurerm_key_vault.domain_kv_dev.id
  tenant_id    = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  object_id    = module.DEV-CSTAR-CORE-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_dev" {
  source = "git::https://github.com/pagopa/azurerm.git//letsencrypt_credential?ref=v2.18.0"

  providers = {
    azurerm = azurerm.dev
  }
  prefix            = local.project_prefix_short
  env               = "d"
  key_vault_name    = local.dev_domain_key_vault_name
  subscription_name = local.dev_subscription_name
}

#
# UAT
#
module "UAT-CSTAR-CORE-TLS-CERT-SERVICE-CONN" {

  providers = {
    azurerm = azurerm.uat
  }

  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v2.1.0"

  project_id        = data.azuredevops_project.project.id
  name              = "${local.project_prefix_short}-u-${local.domain}-tls-cert"
  tenant_id         = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  subscription_name = local.uat_subscription_name
  subscription_id   = module.secret_azdo.values["PAGOPAIT-UAT-CSTAR-SUBSCRIPTION-ID"].value
  #tfsec:ignore:GEN003
  renew_token = local.tlscert_renew_token

  credential_subcription              = local.uat_subscription_name
  credential_key_vault_name           = local.uat_domain_key_vault_name
  credential_key_vault_resource_group = local.uat_domain_key_vault_resource_group
}

resource "azurerm_key_vault_access_policy" "UAT-CSTAR-CORE-TLS-CERT-SERVICE-CONN_kv_access_policy" {
  provider     = azurerm.uat
  key_vault_id = data.azurerm_key_vault.domain_kv_uat.id
  tenant_id    = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  object_id    = module.UAT-CSTAR-CORE-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_uat" {
  source = "git::https://github.com/pagopa/azurerm.git//letsencrypt_credential?ref=v2.18.0"

  providers = {
    azurerm = azurerm.uat
  }
  prefix            = local.project_prefix_short
  env               = "u"
  key_vault_name    = local.uat_domain_key_vault_name
  subscription_name = local.uat_subscription_name
}

#
# PROD
#
module "PROD-CSTAR-CORE-TLS-CERT-SERVICE-CONN" {

  providers = {
    azurerm = azurerm.prod
  }

  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v2.1.0"

  project_id        = data.azuredevops_project.project.id
  name              = "${local.project_prefix_short}-p-${local.domain}-tls-cert"
  tenant_id         = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  subscription_name = local.prod_subscription_name
  subscription_id   = module.secret_azdo.values["PAGOPAIT-PROD-CSTAR-SUBSCRIPTION-ID"].value
  #tfsec:ignore:GEN003
  renew_token = local.tlscert_renew_token

  credential_subcription              = local.prod_subscription_name
  credential_key_vault_name           = local.prod_domain_key_vault_name
  credential_key_vault_resource_group = local.prod_domain_key_vault_resource_group
}

resource "azurerm_key_vault_access_policy" "PROD-CSTAR-CORE-TLS-CERT-SERVICE-CONN_kv_access_policy" {
  provider     = azurerm.prod
  key_vault_id = data.azurerm_key_vault.domain_kv_prod.id
  tenant_id    = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  object_id    = module.PROD-CSTAR-CORE-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_prod" {
  source = "git::https://github.com/pagopa/azurerm.git//letsencrypt_credential?ref=v2.18.0"

  providers = {
    azurerm = azurerm.prod
  }
  prefix            = local.project_prefix_short
  env               = "p"
  key_vault_name    = local.prod_domain_key_vault_name
  subscription_name = local.prod_subscription_name
}
