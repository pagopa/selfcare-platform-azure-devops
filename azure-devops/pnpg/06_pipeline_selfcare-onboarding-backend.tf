variable "selfcare-onboarding-backend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-onboarding-backend"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "pnpg"
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "pnpg\\selfcare-onboarding-backend"
    }
  }
}

locals {
  # global vars
  selfcare-onboarding-backend-variables = {
    settings_xml_rw_secure_file_name = "settings-rw.xml"
    settings_xml_ro_secure_file_name = "settings-ro.xml"
    maven_remote_repo_server_id      = "selfcare-platform"
    maven_remote_repo                = "https://pkgs.dev.azure.com/pagopaspa/selfcare-platform-app-projects/_packaging/selfcare-platform/maven/v1"
    dockerfile                       = "Dockerfile"
  }
  # global secrets
  selfcare-onboarding-backend-variables_secret = {

  }
  # code_review vars
  selfcare-onboarding-backend-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.selfcare-onboarding-backend.repository.organization
    sonarcloud_project_key  = "${var.selfcare-onboarding-backend.repository.organization}_${var.selfcare-onboarding-backend.repository.name}"
    sonarcloud_project_name = var.selfcare-onboarding-backend.repository.name
  }
  # code_review secrets
  selfcare-onboarding-backend-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-onboarding-backend-variables_deploy = {

    k8s_image_repository_name        = replace(var.selfcare-onboarding-backend.repository.name, "-", "")
    deploy_namespace                 = local.domain
    deployment_name                  = "b4f-onboarding"
    helm_release_name                = var.selfcare-onboarding-backend.repository.name
  }
  # deploy secrets
  selfcare-onboarding-backend-variables_secret_deploy = {

  }
}

module "selfcare-onboarding-backend_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.selfcare-onboarding-backend.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-onboarding-backend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_pr.service_endpoint_id
  path                         = var.selfcare-onboarding-backend.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare-onboarding-backend-variables,
    local.selfcare-onboarding-backend-variables_code_review,
  )

  variables_secret = merge(
    local.selfcare-onboarding-backend-variables_secret,
    local.selfcare-onboarding-backend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "selfcare-onboarding-backend_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-onboarding-backend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-onboarding-backend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-onboarding-backend.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.selc-be-common-variables_deploy,
    local.selfcare-onboarding-backend-variables,
    local.selfcare-onboarding-backend-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-onboarding-backend-variables_secret,
    local.selfcare-onboarding-backend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]
}
