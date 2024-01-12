
module "DEV-SELFCARE-TLS-CERT-SERVICE-CONN" {
  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v4.1.1"

  project_id        = data.azuredevops_project.project.id
  name              = "selc-d-tls-cert"
  tenant_id         = module.secrets.values["PAGOPAIT-TENANTID"].value
  subscription_id   = module.secrets.values["PAGOPAIT-DEV-SELFCARE-SUBSCRIPTION-ID"].value
  subscription_name = "DEV-SelfCare"
  #tfsec:ignore:GEN003
  renew_token = local.tlscert_renew_token

  credential_subcription              = local.core_key_vault_subscription_name
  credential_key_vault_name           = local.core_key_vault_name
  credential_key_vault_resource_group = local.core_key_vault_resource_group
}

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_dev" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential?ref=v7.35.0"

  providers = {
    azurerm = azurerm.dev
  }
  prefix            = local.prefix
  env               = "d"
  key_vault_name    = local.dev_key_vault_name
  subscription_name = local.dev_selfcare_subscription_name
}

#
# UAT
#

module "UAT-SELFCARE-TLS-CERT-SERVICE-CONN" {
  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v4.1.1"

  project_id        = data.azuredevops_project.project.id
  name              = "selc-u-tls-cert"
  tenant_id         = module.secrets.values["PAGOPAIT-TENANTID"].value
  subscription_id   = module.secrets.values["PAGOPAIT-UAT-SELFCARE-SUBSCRIPTION-ID"].value
  subscription_name = "UAT-SelfCare"
  #tfsec:ignore:GEN003
  renew_token = local.tlscert_renew_token

  credential_subcription              = local.core_key_vault_subscription_name
  credential_key_vault_name           = local.core_key_vault_name
  credential_key_vault_resource_group = local.core_key_vault_resource_group
}

module "letsencrypt_uat" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential?ref=v7.35.0"

  providers = {
    azurerm = azurerm.uat
  }
  prefix            = local.prefix
  env               = "u"
  key_vault_name    = local.uat_key_vault_name
  subscription_name = local.uat_selfcare_subscription_name
}

#
# PROD
#

module "PROD-SELFCARE-TLS-CERT-SERVICE-CONN" {
  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v4.1.1"

  project_id        = data.azuredevops_project.project.id
  name              = "selc-p-tls-cert"
  tenant_id         = module.secrets.values["PAGOPAIT-TENANTID"].value
  subscription_id   = module.secrets.values["PAGOPAIT-PROD-SELFCARE-SUBSCRIPTION-ID"].value
  subscription_name = "PROD-SelfCare"
  #tfsec:ignore:GEN003
  renew_token = local.tlscert_renew_token

  credential_subcription              = local.core_key_vault_subscription_name
  credential_key_vault_name           = local.core_key_vault_name
  credential_key_vault_resource_group = local.core_key_vault_resource_group
}

# create let's encrypt credential used to create SSL certificates
module "letsencrypt_prod" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential?ref=v7.35.0"

  providers = {
    azurerm = azurerm.prod
  }
  prefix            = local.prefix
  env               = "p"
  key_vault_name    = local.prod_key_vault_name
  subscription_name = local.prod_selfcare_subscription_name
}
