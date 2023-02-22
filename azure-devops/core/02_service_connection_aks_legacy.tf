
# DEV service connection for azure kubernetes service
resource "azuredevops_serviceendpoint_kubernetes" "selfcare-aks-dev" {
  depends_on            = [data.azuredevops_project.project]
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "selfcare-aks-dev"
  apiserver_url         = module.dev_secrets.values["dev-selfcare-aks-apiserver-url"].value
  authorization_type    = "ServiceAccount"
  service_account {
    # base64 values
    token   = module.dev_secrets.values["dev-selfcare-aks-azure-devops-sa-token"].value
    ca_cert = module.dev_secrets.values["dev-selfcare-aks-azure-devops-sa-cacrt"].value
  }
}

# UAT service connection for azure kubernetes service
resource "azuredevops_serviceendpoint_kubernetes" "selfcare-aks-uat" {
  depends_on            = [data.azuredevops_project.project]
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "selfcare-aks-uat"
  apiserver_url         = module.uat_secrets.values["uat-selfcare-aks-apiserver-url"].value
  authorization_type    = "ServiceAccount"
  service_account {
    # base64 values
    token   = module.uat_secrets.values["uat-selfcare-aks-azure-devops-sa-token"].value
    ca_cert = module.uat_secrets.values["uat-selfcare-aks-azure-devops-sa-cacrt"].value
  }
}

# PROD service connection for azure kubernetes service
resource "azuredevops_serviceendpoint_kubernetes" "selfcare-aks-prod" {
  depends_on            = [data.azuredevops_project.project]
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "selfcare-aks-prod"
  apiserver_url         = module.prod_secrets.values["prod-selfcare-aks-apiserver-url"].value
  authorization_type    = "ServiceAccount"
  service_account {
    # base64 values
    token   = module.prod_secrets.values["prod-selfcare-aks-azure-devops-sa-token"].value
    ca_cert = module.prod_secrets.values["prod-selfcare-aks-azure-devops-sa-cacrt"].value
  }
}
