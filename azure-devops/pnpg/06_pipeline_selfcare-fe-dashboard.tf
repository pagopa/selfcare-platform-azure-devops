variable "selfcare-dashboard-frontend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-dashboard-frontend"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "pnpg\\selfcare-dashboard-frontend"
    }
  }
}

locals {
  # global vars
  selfcare-dashboard-frontend-variables = {
    default_branch = var.selfcare-dashboard-frontend.repository.branch_name
  }
  # global secrets
  selfcare-dashboard-frontend-variables_secret = {

  }
  # code_review vars
  selfcare-dashboard-frontend-variables_code_review = {
    danger_github_api_token = "skip"
  }
  # code_review secrets
  selfcare-dashboard-frontend-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-dashboard-frontend-variables_deploy = {

  }
  # deploy secrets
  selfcare-dashboard-frontend-variables_secret_deploy = {

  }
}

module "selfcare-dashboard-frontend_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.selfcare-dashboard-frontend.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-dashboard-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-dashboard-frontend.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare-dashboard-frontend-variables,
    local.selfcare-dashboard-frontend-variables_code_review,
  )

  variables_secret = merge(
    local.selfcare-dashboard-frontend-variables_secret,
    local.selfcare-dashboard-frontend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id
  ]
}

module "selfcare-dashboard-frontend_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-dashboard-frontend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-dashboard-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-dashboard-frontend.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.selc-fe-common-variables_deploy-pnpg,
    local.selfcare-dashboard-frontend-variables,
    local.selfcare-dashboard-frontend-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-dashboard-frontend-variables_secret,
    local.selfcare-dashboard-frontend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
  ]
}
