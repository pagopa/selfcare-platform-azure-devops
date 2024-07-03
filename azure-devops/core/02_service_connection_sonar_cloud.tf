resource "azuredevops_serviceendpoint_sonarcloud" "sonarcloud" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "SONARCLOUD-SERVICE-CONN"
  token                 = module.secrets.values["sonar-token"].value
  description           = "Managed by Terraform"
}
