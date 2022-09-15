#
# Github
#
output "service_endpoint_io_azure_devops_github_pr_id" {
  value = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
}

output "service_endpoint_azure_devops_github_pr_name" {
  value = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.service_endpoint_name
}

output "service_endpoint_io_azure_devops_github_ro_id" {
  value = azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id
}

output "service_endpoint_io_azure_devops_github_ro_name" {
  value = azuredevops_serviceendpoint_github.io-azure-devops-github-ro.service_endpoint_name
}

#
# Docker registry
#
output "service_endpoint_azure_devops_acr_dev_name" {
  value = azuredevops_serviceendpoint_azurecr.cstar-azurecrcommon-dev.service_endpoint_name
}

output "service_endpoint_azure_devops_acr_dev_id" {
  value = azuredevops_serviceendpoint_azurecr.cstar-azurecrcommon-dev.id
}

output "service_endpoint_azure_devops_acr_uat_name" {
  value = azuredevops_serviceendpoint_azurecr.cstar-azurecrcommon-uat.service_endpoint_name
}

output "service_endpoint_azure_devops_acr_uat_id" {
  value = azuredevops_serviceendpoint_azurecr.cstar-azurecrcommon-uat.id
}

#
# Azure
#
output "service_endpoint_azure_dev_id" {
  value = azuredevops_serviceendpoint_azurerm.DEV-CSTAR.id
}

output "service_endpoint_azure_uat_id" {
  value = azuredevops_serviceendpoint_azurerm.UAT-CSTAR.id
}
