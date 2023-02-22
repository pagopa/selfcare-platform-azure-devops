# DEV service connection for azure container registry
resource "azuredevops_serviceendpoint_azurecr" "selfcare-docker-common-dev" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "selc-docker-common-dev"
  resource_group            = "selc-d-docker-rg"
  azurecr_name              = "selcdcommonacr"
  azurecr_subscription_name = "DEV-SelfCare"
  azurecr_spn_tenantid      = module.secrets.values["PAGOPAIT-TENANTID"].value
  azurecr_subscription_id   = module.secrets.values["PAGOPAIT-DEV-SELFCARE-SUBSCRIPTION-ID"].value
}

# UAT service connection for azure container registry
resource "azuredevops_serviceendpoint_azurecr" "selfcare-docker-common-uat" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "selc-docker-common-uat"
  resource_group            = "selc-u-docker-rg"
  azurecr_name              = "selcucommonacr"
  azurecr_subscription_name = "UAT-SelfCare"
  azurecr_spn_tenantid      = module.secrets.values["PAGOPAIT-TENANTID"].value
  azurecr_subscription_id   = module.secrets.values["PAGOPAIT-UAT-SELFCARE-SUBSCRIPTION-ID"].value
}

# PROD service connection for azure container registry
resource "azuredevops_serviceendpoint_azurecr" "selfcare-docker-common-prod" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "selc-docker-common-prod"
  resource_group            = "selc-p-docker-rg"
  azurecr_name              = "selcpcommonacr"
  azurecr_subscription_name = "PROD-SelfCare"
  azurecr_spn_tenantid      = module.secrets.values["PAGOPAIT-TENANTID"].value
  azurecr_subscription_id   = module.secrets.values["PAGOPAIT-PROD-SELFCARE-SUBSCRIPTION-ID"].value
}
