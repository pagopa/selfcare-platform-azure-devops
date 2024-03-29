variable "selc-fe-login" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-login-frontend"
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
  selc-fe-login-variables = {
    default_branch = var.selc-fe-login.repository.branch_name
  }
  # global secrets
  selc-fe-login-variables_secret = {

  }
  # code_review vars
  selc-fe-login-variables_code_review = {
    danger_github_api_token = "skip"
  }
  # code_review secrets
  selc-fe-login-variables_secret_code_review = {

  }
  # deploy vars
  selc-fe-login-variables_deploy = {

  }
  # deploy secrets
  selc-fe-login-variables_secret_deploy = {

  }
}

module "selc-fe-login_code_review" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_code_review?ref=v6.0.0"
  count  = var.selc-fe-login.pipeline.enable_code_review == true ? 1 : 0

  project_id                    = data.azuredevops_project.project.id
  repository                    = var.selc-fe-login.repository
  github_service_connection_id  = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                          = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-fe-login.repository.name}"
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selc-fe-login-variables,
    local.selc-fe-login-variables_code_review,
  )

  variables_secret = merge(
    local.selc-fe-login-variables_secret,
    local.selc-fe-login-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id
  ]
}

module "selc-fe-login_deploy" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_deploy?ref=v4.1.3"
  count  = var.selc-fe-login.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selc-fe-login.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id
  path                         = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-fe-login.repository.name}"
  ci_trigger_use_yaml          = true

  variables = merge(
    local.selc-fe-common-variables_deploy,
    local.selc-fe-login-variables,
    local.selc-fe-login-variables_deploy,
  )

  variables_secret = merge(
    local.selc-fe-login-variables_secret,
    local.selc-fe-login-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-SELFCARE.id,
    azuredevops_serviceendpoint_azurerm.UAT-SELFCARE.id,
    azuredevops_serviceendpoint_azurerm.PROD-SELFCARE.id,
  ]
}
