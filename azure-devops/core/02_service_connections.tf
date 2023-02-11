# Github docker registry (read-only)
resource "azuredevops_serviceendpoint_dockerregistry" "github_docker_registry_ro" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "github-docker-registry-ro"
  docker_registry       = "https://ghcr.io"
  docker_username       = module.secrets.values["SELC-DOCKER-REGISTRY-PAGOPA-USER"].value
  docker_password       = module.secrets.values["SELC-DOCKER-REGISTRY-PAGOPA-TOKEN-RO"].value
  registry_type         = "Others"
}

# npm service connection
resource "azuredevops_serviceendpoint_npm" "pagopa-npm-bot" {
  depends_on = [data.azuredevops_project.project]

  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = "pagopa-npm-bot"
  url                   = "https://registry.npmjs.org"
  access_token          = module.secrets.values["pagopa-npm-bot-TOKEN"].value
}
