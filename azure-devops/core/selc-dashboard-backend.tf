variable "selc-dashboard-backend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-dashboard-backend"
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
  selc-dashboard-backend-variables = {
    settings_xml_rw_secure_file_name = "settings-rw.xml"
    settings_xml_ro_secure_file_name = "settings-ro.xml"
    maven_remote_repo_server_id      = "selfcare-platform"
    maven_remote_repo                = "https://pkgs.dev.azure.com/pagopaspa/selfcare-platform-app-projects/_packaging/selfcare-platform/maven/v1"
    dockerfile                       = "Dockerfile"
  }
  # global secrets
  selc-dashboard-backend-variables_secret = {

  }
  # code_review vars
  selc-dashboard-backend-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.selc-dashboard-backend.repository.organization
    sonarcloud_project_key  = "${var.selc-dashboard-backend.repository.organization}_${var.selc-dashboard-backend.repository.name}"
    sonarcloud_project_name = var.selc-dashboard-backend.repository.name
  }
  # code_review secrets
  selc-dashboard-backend-variables_secret_code_review = {

  }
  # deploy vars
  selc-dashboard-backend-variables_deploy = {
    k8s_image_repository_name = replace(var.selc-dashboard-backend.repository.name, "-", "")
    deploy_namespace          = "selc"
    deployment_name           = "b4f-dashboard"
  }
  # deploy secrets
  selc-dashboard-backend-variables_secret_deploy = {

  }
}

module "selc-dashboard-backend_code_review" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_code_review?ref=v6.0.0"
  count  = var.selc-dashboard-backend.pipeline.enable_code_review == true ? 1 : 0

  project_id                    = data.azuredevops_project.project.id
  repository                    = var.selc-dashboard-backend.repository
  github_service_connection_id  = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                          = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-dashboard-backend.repository.name}"
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selc-dashboard-backend-variables,
    local.selc-dashboard-backend-variables_code_review,
  )

  variables_secret = merge(
    local.selc-dashboard-backend-variables_secret,
    local.selc-dashboard-backend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_sonarcloud.sonarcloud.id,
  ]
}

module "selc-dashboard-backend_deploy" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_deploy?ref=v4.1.3"
  count  = var.selc-dashboard-backend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selc-dashboard-backend.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                         = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-dashboard-backend.repository.name}"
  ci_trigger_use_yaml          = true

  variables = merge(
    local.selc-be-common-variables_deploy,
    local.selc-dashboard-backend-variables,
    local.selc-dashboard-backend-variables_deploy,
  )

  variables_secret = merge(
    local.selc-dashboard-backend-variables_secret,
    local.selc-dashboard-backend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_azurerm.DEV-SELFCARE.id,
    azuredevops_serviceendpoint_azurecr.selfcare-azurecr-dev.id,
    azuredevops_serviceendpoint_kubernetes.selfcare-aks-dev.id,
    azuredevops_serviceendpoint_azurerm.UAT-SELFCARE.id,
    azuredevops_serviceendpoint_azurecr.selfcare-azurecr-uat.id,
    azuredevops_serviceendpoint_kubernetes.selfcare-aks-uat.id,
    azuredevops_serviceendpoint_azurerm.PROD-SELFCARE.id,
    azuredevops_serviceendpoint_azurecr.selfcare-azurecr-prod.id,
    azuredevops_serviceendpoint_kubernetes.selfcare-aks-prod.id,
  ]
}
