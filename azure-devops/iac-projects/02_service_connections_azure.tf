#
# ⛩ Service connections
#

# DEV service connection
resource "azuredevops_serviceendpoint_azurerm" "DEV-CSTAR" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "DEV-CSTAR-SERVICE-CONN"
  description               = "DEV-CSTAR Service connection"
  azurerm_subscription_name = "DEV-CSTAR"
  azurerm_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secret_azdo.values["PAGOPAIT-DEV-CSTAR-SUBSCRIPTION-ID"].value
}

# UAT service connection
resource "azuredevops_serviceendpoint_azurerm" "UAT-CSTAR" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "UAT-CSTAR-SERVICE-CONN"
  description               = "UAT-CSTAR Service connection"
  azurerm_subscription_name = "UAT-CSTAR"
  azurerm_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secret_azdo.values["PAGOPAIT-UAT-CSTAR-SUBSCRIPTION-ID"].value
}

# PROD service connection
resource "azuredevops_serviceendpoint_azurerm" "PROD-CSTAR" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = "PROD-CSTAR-SERVICE-CONN"
  description               = "PROD-CSTAR Service connection"
  azurerm_subscription_name = "PROD-CSTAR"
  azurerm_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurerm_subscription_id   = module.secret_azdo.values["PAGOPAIT-PROD-CSTAR-SUBSCRIPTION-ID"].value
}
