variable "selfcare-pnpg-onboarding-frontend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-pnpg-onboarding-frontend"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "pnpg\\selfcare-pnpg-onboarding-frontend"
    }
  }
}

locals {
  # global vars
  selfcare-pnpg-onboarding-frontend-variables = {
    default_branch = var.selfcare-pnpg-onboarding-frontend.repository.branch_name
  }
  # global secrets
  selfcare-pnpg-onboarding-frontend-variables_secret = {

  }
  # code_review vars
  selfcare-pnpg-onboarding-frontend-variables_code_review = {
    danger_github_api_token = "skip"
  }
  # code_review secrets
  selfcare-pnpg-onboarding-frontend-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-pnpg-onboarding-frontend-variables_deploy = {

  }
  # deploy secrets
  selfcare-pnpg-onboarding-frontend-variables_secret_deploy = {

  }
}

module "selfcare-pnpg-onboarding-frontend_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.selfcare-pnpg-onboarding-frontend.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-pnpg-onboarding-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  path                         = var.selfcare-pnpg-onboarding-frontend.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare-pnpg-onboarding-frontend-variables,
    local.selfcare-pnpg-onboarding-frontend-variables_code_review,
  )

  variables_secret = merge(
    local.selfcare-pnpg-onboarding-frontend-variables_secret,
    local.selfcare-pnpg-onboarding-frontend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  ]
}

module "selfcare-pnpg-onboarding-frontend_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-pnpg-onboarding-frontend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-pnpg-onboarding-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  path                         = var.selfcare-pnpg-onboarding-frontend.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.selc-fe-common-variables_deploy-pnpg,
    local.selfcare-pnpg-onboarding-frontend-variables,
    local.selfcare-pnpg-onboarding-frontend-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-pnpg-onboarding-frontend-variables_secret,
    local.selfcare-pnpg-onboarding-frontend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.id,
    # data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    # data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    # local.service_endpoint_azure_devops_docker_dev_id,
    # azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]
}
