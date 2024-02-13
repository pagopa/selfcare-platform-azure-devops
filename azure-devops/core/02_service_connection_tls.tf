
module "DEV-SELFCARE-TLS-CERT-SERVICE-CONN" {
  providers = {
    azurerm = azurerm.dev
  }

  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated?ref=v6.0.0"

  resource_group_name = local.dev_resource_group_name
  location            = local.location
  project_id          = data.azuredevops_project.project.id
  name                = "selc-d-tls-cert"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  subscription_id     = data.azurerm_subscriptions.dev.subscriptions[0].subscription_id
  subscription_name   = "DEV-SelfCare"
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
  providers = {
    azurerm = azurerm.uat
  }
  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated?ref=v4.1.3"

  resource_group_name = local.uat_resource_group_name
  location            = local.location
  project_id          = data.azuredevops_project.project.id
  name                = "selc-u-tls-cert"
  tenant_id           = module.secrets.values["PAGOPAIT-TENANTID"].value
  subscription_id     = module.secrets.values["PAGOPAIT-UAT-SELFCARE-SUBSCRIPTION-ID"].value
  subscription_name   = "UAT-SelfCare"
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
  providers = {
    azurerm = azurerm.prod
  }
  depends_on = [data.azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_federated?ref=v4.1.3"

  resource_group_name = local.prod_resource_group_name
  location            = local.location
  project_id          = data.azuredevops_project.project.id
  name                = "selc-p-tls-cert"
  tenant_id           = module.secrets.values["PAGOPAIT-TENANTID"].value
  subscription_id     = module.secrets.values["PAGOPAIT-PROD-SELFCARE-SUBSCRIPTION-ID"].value
  subscription_name   = "PROD-SelfCare"
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
