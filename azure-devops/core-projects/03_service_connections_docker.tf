# DEV service connection for azure container registry 
resource "azuredevops_serviceendpoint_azurecr" "cstar-azurecrcommon-dev" {
  depends_on = [data.azuredevops_project.project]

  project_id                = data.azuredevops_project.project.id
  service_endpoint_name     = local.srv_endpoint_name_docker_registry_dev
  resource_group            = local.docker_registry_rg_name_dev
  azurecr_name              = local.docker_registry_name_dev
  azurecr_subscription_name = "DEV-CSTAR"
  azurecr_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
  azurecr_subscription_id   = module.secret_azdo.values["PAGOPAIT-DEV-CSTAR-SUBSCRIPTION-ID"].value
}

# # UAT service connection for azure container registry 
# resource "azuredevops_serviceendpoint_azurecr" "cstar-azurecrcommon-uat" {
#   depends_on = [data.azuredevops_project.project]

#   project_id                = data.azuredevops_project.project.id
#   service_endpoint_name     = "cstar-azurecr-uat"
#   resource_group            = "cstar-u-aks-rg"
#   azurecr_name              = "cstaruacr"
#   azurecr_subscription_name = "UAT-CSTAR"
#   azurecr_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
#   azurecr_subscription_id   = module.secret_azdo.values["PAGOPAIT-UAT-CSTAR-SUBSCRIPTION-ID"].value
# }

# # PROD service connection for azure container registry 
# resource "azuredevops_serviceendpoint_azurecr" "cstar-azurecrcommon-prod" {
#   depends_on = [data.azuredevops_project.project]

#   project_id                = data.azuredevops_project.project.id
#   service_endpoint_name     = "cstar-azurecr-prod"
#   resource_group            = "cstar-p-aks-rg"
#   azurecr_name              = "cstarpacr"
#   azurecr_subscription_name = "PROD-CSTAR"
#   azurecr_spn_tenantid      = module.secret_azdo.values["PAGOPAIT-TENANTID"].value
#   azurecr_subscription_id   = module.secret_azdo.values["PAGOPAIT-PROD-CSTAR-SUBSCRIPTION-ID"].value
# }
