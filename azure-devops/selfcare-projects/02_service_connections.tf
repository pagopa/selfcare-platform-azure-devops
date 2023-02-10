# Github docker registry (read-only)
resource "azuredevops_serviceendpoint_dockerregistry" "github_docker_registry_ro" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "github-docker-registry-ro"
  docker_registry       = "https://ghcr.io"
  docker_username       = module.secrets.values["SELC-DOCKER-REGISTRY-PAGOPA-USER"].value
  docker_password       = module.secrets.values["SELC-DOCKER-REGISTRY-PAGOPA-TOKEN-RO"].value
  registry_type         = "Others"
}

# TODO azure devops terraform provider does not support SonarCloud service endpoint
locals {
  azuredevops_serviceendpoint_sonarcloud_id = "4126bdf1-3b2f-4e34-b9e7-4508d8de8ebe"
}

# npm service connection
resource "azuredevops_serviceendpoint_npm" "pagopa-npm-bot" {
  depends_on = [azuredevops_project.project]

  project_id            = azuredevops_project.project.id
  service_endpoint_name = "pagopa-npm-bot"
  url                   = "https://registry.npmjs.org"
  access_token          = module.secrets.values["pagopa-npm-bot-TOKEN"].value
}
