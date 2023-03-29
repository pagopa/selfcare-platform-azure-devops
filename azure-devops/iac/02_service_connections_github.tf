data "azuredevops_serviceendpoint_github" "github_ro" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = var.service_endpoint_io_azure_devops_github_ro_name
}

data "azuredevops_serviceendpoint_github" "github_rw" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = var.service_endpoint_io_azure_devops_github_rw_name
}

data "azuredevops_serviceendpoint_github" "github_pr" {
  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = var.service_endpoint_io_azure_devops_github_pr_name
}
