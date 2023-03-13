variable "selfcare-token-exchange-frontend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-token-exchange-frontend"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "pnpg\\selfcare-token-exchange-frontend"
    }
  }
}

locals {
  # global vars
  selfcare-token-exchange-frontend-variables = {
    default_branch = var.selfcare-pnpg-onboarding-frontend.repository.branch_name
  }
  # global secrets
  selfcare-token-exchange-frontend-variables_secret = {

  }
  # code_review vars
  selfcare-token-exchange-frontend-variables_code_review = {
    danger_github_api_token = "skip"
  }
  # code_review secrets
  selfcare-token-exchange-frontend-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-token-exchange-frontend-variables_deploy = {

  }
  # deploy secrets
  selfcare-token-exchange-frontend-variables_secret_deploy = {

  }
}

module "selfcare-token-exchange-frontend_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.selfcare-token-exchange-frontend.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-token-exchange-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-token-exchange-frontend.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare-token-exchange-frontend-variables,
    local.selfcare-token-exchange-frontend-variables_code_review,
  )

  variables_secret = merge(
    local.selfcare-token-exchange-frontend-variables_secret,
    local.selfcare-token-exchange-frontend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id
  ]
}

module "selfcare-token-exchange-frontend_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-token-exchange-frontend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-token-exchange-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-token-exchange-frontend.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.selc-fe-common-variables_deploy-pnpg,
    local.selfcare-token-exchange-frontend-variables,
    local.selfcare-token-exchange-frontend-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-token-exchange-frontend-variables_secret,
    local.selfcare-token-exchange-frontend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
  ]
}
