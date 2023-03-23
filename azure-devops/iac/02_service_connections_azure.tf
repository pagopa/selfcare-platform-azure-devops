#
# ⛩ Service connections
#

# DEV service connection
resource "azuredevops_serviceendpoint_azurerm" "DEV-SELC" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "DEV-SELC-SERVICE-CONN"
  description               = "DEV-SELC Service connection"
  azurerm_subscription_name = "DEV-SELC"
  azurerm_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secret_azdo.values["PAGOPAIT-DEV-SELC-SUBSCRIPTION-ID"].value
}

# UAT service connection
resource "azuredevops_serviceendpoint_azurerm" "UAT-SELC" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "UAT-SELC-SERVICE-CONN"
  description               = "UAT-SELC Service connection"
  azurerm_subscription_name = "UAT-SELC"
  azurerm_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secret_azdo.values["PAGOPAIT-UAT-SELC-SUBSCRIPTION-ID"].value
}

# PROD service connection
resource "azuredevops_serviceendpoint_azurerm" "PROD-SELC" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "PROD-SELC-SERVICE-CONN"
  description               = "PROD-SELC Service connection"
  azurerm_subscription_name = "PROD-SELC"
  azurerm_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secret_azdo.values["PAGOPAIT-PROD-SELC-SUBSCRIPTION-ID"].value
}
