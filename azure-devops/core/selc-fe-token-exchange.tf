variable "selc-fe-token-exchange" {
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
    }
  }
}

locals {
  # global vars
  selc-fe-token-exchange-variables = {
    default_branch = var.selc-fe-token-exchange.repository.branch_name
  }
  # global secrets
  selc-fe-token-exchange-variables_secret = {

  }
  # code_review vars
  selc-fe-token-exchange-variables_code_review = {
    danger_github_api_token = "skip"
  }
  # code_review secrets
  selc-fe-token-exchange-variables_secret_code_review = {

  }
  # deploy vars
  selc-fe-token-exchange-variables_deploy = {

  }
  # deploy secrets
  selc-fe-token-exchange-variables_secret_deploy = {

  }
}

module "selc-fe-token-exchange_code_review" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_code_review?ref=v6.0.0"
  count  = var.selc-fe-token-exchange.pipeline.enable_code_review == true ? 1 : 0

  project_id                    = data.azuredevops_project.project.id
  repository                    = var.selc-fe-token-exchange.repository
  github_service_connection_id  = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                          = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-fe-token-exchange.repository.name}"
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selc-fe-token-exchange-variables,
    local.selc-fe-token-exchange-variables_code_review,
  )

  variables_secret = merge(
    local.selc-fe-token-exchange-variables_secret,
    local.selc-fe-token-exchange-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id
  ]
}

module "selc-fe-token-exchange_deploy" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_deploy?ref=v6.0.0"
  count  = var.selc-fe-token-exchange.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selc-fe-token-exchange.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id
  path                         = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-fe-token-exchange.repository.name}"
  ci_trigger_use_yaml          = true

  variables = merge(
    local.selc-fe-common-variables_deploy,
    local.selc-fe-token-exchange-variables,
    local.selc-fe-token-exchange-variables_deploy,
  )

  variables_secret = merge(
    local.selc-fe-token-exchange-variables_secret,
    local.selc-fe-token-exchange-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-SELFCARE.id,
    azuredevops_serviceendpoint_azurerm.UAT-SELFCARE.id,
    azuredevops_serviceendpoint_azurerm.PROD-SELFCARE.id,
  ]
}
