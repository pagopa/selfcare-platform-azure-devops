variable "selfcare-common-frontend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-common-frontend"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "pnpg"
    }
    pipeline = {
      enable_code_review = false
      enable_deploy      = true
      path               = "pnpg\\selfcare-common-frontend"
    }
  }
}

locals {
  # global vars
  selfcare-common-frontend-variables = {
    default_branch = var.selfcare-common-frontend.repository.branch_name
    # settings_xml_rw_secure_file_name = "settings-rw.xml"
    # settings_xml_ro_secure_file_name = "settings-ro.xml"
    # maven_remote_repo_server_id      = "selfcare-platform"
    # maven_remote_repo                = "https://pkgs.dev.azure.com/pagopaspa/selfcare-platform-app-projects/_packaging/selfcare-platform/maven/v1"
    # dockerfile                       = "Dockerfile"
  }
  # global secrets
  selfcare-common-frontend-variables_secret = {

  }
  # code_review vars
  selfcare-common-frontend-variables_code_review = {
    danger_github_api_token = "skip"
    # sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    # sonarcloud_org          = var.selfcare-common-frontend.repository.organization
    # sonarcloud_project_key  = "${var.selfcare-common-frontend.repository.organization}_${var.selfcare-common-frontend.repository.name}"
    # sonarcloud_project_name = var.selfcare-common-frontend.repository.name
  }
  # code_review secrets
  selfcare-common-frontend-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-common-frontend-variables_deploy = {
    npm_connection =  local.service_connection_npm_endpoint_name
  }
  # deploy secrets
  selfcare-common-frontend-variables_secret_deploy = {
    
  }
}

module "selfcare-common-frontend_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.selfcare-common-frontend.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-common-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  path                         = var.selfcare-common-frontend.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare-common-frontend-variables,
    local.selfcare-common-frontend-variables_code_review,
  )

  variables_secret = merge(
    local.selfcare-common-frontend-variables_secret,
    local.selfcare-common-frontend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  ]
}

module "selfcare-common-frontend_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-common-frontend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-common-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  path                         = var.selfcare-common-frontend.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.selfcare-common-frontend-variables,
    local.selfcare-common-frontend-variables_deploy,
    local.selc-fe-common-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-common-frontend-variables_secret,
    local.selfcare-common-frontend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
  ]
}
