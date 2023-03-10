variable "selfcare-login-frontend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-login-frontend"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "pnpg"
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "pnpg\\selfcare-login-frontend"
    }
  }
}

locals {
  # global vars
  selfcare-login-frontend-variables = {
    default_branch = var.selfcare-login-frontend.repository.branch_name
  }
  # global secrets
  selfcare-login-frontend-variables_secret = {

  }
  # code_review vars
  selfcare-login-frontend-variables_code_review = {
    danger_github_api_token = "skip"
  }
  # code_review secrets
  selfcare-login-frontend-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-login-frontend-variables_deploy = {
    dev_react_app_url_file_privacy_disclaimer    = "https://www.pagopa.it/it/informativa-privacy-area-riservata"
    dev_react_app_url_file_terms_and_conditions  = "https://www.pagopa.it/it/termini-condizioni-area-riservata"
    uat_react_app_url_file_privacy_disclaimer    = "https://www.pagopa.it/it/informativa-privacy-area-riservata"
    uat_react_app_url_file_terms_and_conditions  = "https://www.pagopa.it/it/termini-condizioni-area-riservata"
    prod_react_app_url_file_privacy_disclaimer   = "https://www.pagopa.it/it/informativa-privacy-area-riservata"
    prod_react_app_url_file_terms_and_conditions = "https://www.pagopa.it/it/termini-condizioni-area-riservata"
  }
  # deploy secrets
  selfcare-login-frontend-variables_secret_deploy = {

  }
}

module "selfcare-login-frontend_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.selfcare-login-frontend.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-login-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_pr.id
  path                         = var.selfcare-login-frontend.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare-login-frontend-variables,
    local.selfcare-login-frontend-variables_code_review,
  )

  variables_secret = merge(
    local.selfcare-login-frontend-variables_secret,
    local.selfcare-login-frontend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  ]
}

module "selfcare-login-frontend_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-login-frontend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-login-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.id
  path                         = var.selfcare-login-frontend.pipeline.path
  ci_trigger_use_yaml          = true

  variables = merge(
    local.selfcare-login-frontend-variables,
    local.selfcare-login-frontend-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-login-frontend-variables_secret,
    local.selfcare-login-frontend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]
}
