variable "idpay-portal-welfare-frontend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "idpay-portal-welfare-frontend"
      path            = "idpay\\frontend"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
    }
  }
}

locals {
  # global vars
  idpay-portal-welfare-frontend-variables = {
    default_branch = var.idpay-portal-welfare-frontend.repository.branch_name
  }
  # global secrets
  idpay-portal-welfare-frontend-variables_secret = {

  }
  # code_review vars
  idpay-portal-welfare-frontend-variables_code_review = {
    danger_github_api_token = "skip"
  }
  # code_review secrets
  idpay-portal-welfare-frontend-variables_secret_code_review = {

  }
  # deploy vars
  idpay-portal-welfare-frontend-variables_deploy = {

  }
  # deploy secrets
  idpay-portal-welfare-frontend-variables_secret_deploy = {

  }
}

module "idpay-fe-welfare_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.1.0"
  count  = var.idpay-portal-welfare-frontend.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.idpay-portal-welfare-frontend.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.idpay-portal-welfare-frontend-variables,
    local.idpay-portal-welfare-frontend-variables_code_review,
  )

  variables_secret = merge(
    local.idpay-portal-welfare-frontend-variables_secret,
    local.idpay-portal-welfare-frontend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_ro_id,
  ]
}

module "idpay-fe-welfare_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.1.0"
  count  = var.idpay-portal-welfare-frontend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.idpay-portal-welfare-frontend.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_ro_id

  ci_trigger_use_yaml = true

  variables = merge(
    local.idpay-portal-welfare-frontend-variables,
    local.idpay-portal-welfare-frontend-variables_deploy,
  )

  variables_secret = merge(
    local.idpay-portal-welfare-frontend-variables_secret,
    local.idpay-portal-welfare-frontend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_ro_id,
    local.service_endpoint_azure_dev_id,
  ]

}
