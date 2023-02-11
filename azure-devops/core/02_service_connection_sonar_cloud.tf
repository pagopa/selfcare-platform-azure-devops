locals {
  azuredevops_serviceendpoint_sonarcloud_id = "4126bdf1-3b2f-4e34-b9e7-4508d8de8ebe"
}

resource "azuredevops_serviceendpoint_sonarcloud" "sonarcloud" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "SONARCLOUD-SERVICE-CONN"
  token                 = local.azuredevops_serviceendpoint_sonarcloud_id
  description           = "Managed by Terraform"
}
