output "service_connection_sonar_cloud_id" {
  value = azuredevops_serviceendpoint_sonarcloud.sonarcloud.id
}

output "service_connection_docker_registry_common_dev_name" {
  value = azuredevops_serviceendpoint_azurecr.selfcare-docker-common-dev.service_endpoint_name
}

output "service_connection_docker_registry_common_uat_name" {
  value = azuredevops_serviceendpoint_azurecr.selfcare-docker-common-uat.service_endpoint_name
}

output "service_connection_docker_registry_common_prod_name" {
  value = azuredevops_serviceendpoint_azurecr.selfcare-docker-common-prod.service_endpoint_name
}

output "service_connection_docker_registry_common_dev_id" {
  value = azuredevops_serviceendpoint_azurecr.selfcare-docker-common-dev.id
}

output "service_connection_docker_registry_common_uat_id" {
  value = azuredevops_serviceendpoint_azurecr.selfcare-docker-common-uat.id
}

output "service_connection_docker_registry_common_prod_id" {
  value = azuredevops_serviceendpoint_azurecr.selfcare-docker-common-prod.id
}
