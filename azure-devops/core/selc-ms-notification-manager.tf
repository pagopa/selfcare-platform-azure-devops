variable "selc-ms-notification-manager" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-ms-notification-manager"
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
  selc-ms-notification-manager-variables = {
    settings_xml_rw_secure_file_name = "settings-rw.xml"
    settings_xml_ro_secure_file_name = "settings-ro.xml"
    maven_remote_repo_server_id      = "selfcare-platform"
    maven_remote_repo                = "https://pkgs.dev.azure.com/pagopaspa/selfcare-platform-app-projects/_packaging/selfcare-platform/maven/v1"
    dockerfile                       = "Dockerfile"
  }
  # global secrets
  selc-ms-notification-manager-variables_secret = {

  }
  # code_review vars
  selc-ms-notification-manager-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.selc-ms-notification-manager.repository.organization
    sonarcloud_project_key  = "${var.selc-ms-notification-manager.repository.organization}_${var.selc-ms-notification-manager.repository.name}"
    sonarcloud_project_name = var.selc-ms-notification-manager.repository.name
  }
  # code_review secrets
  selc-ms-notification-manager-variables_secret_code_review = {

  }
  # deploy vars
  selc-ms-notification-manager-variables_deploy = {
    k8s_image_repository_name = replace(var.selc-ms-notification-manager.repository.name, "-", "")
    deploy_namespace          = "selc"
    deployment_name           = "ms-notification-manager"
  }
  # deploy secrets
  selc-ms-notification-manager-variables_secret_deploy = {

  }
}

module "selc-ms-notification-manager_code_review" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_code_review?ref=v6.0.0"
  count  = var.selc-ms-notification-manager.pipeline.enable_code_review == true ? 1 : 0

  project_id                    = data.azuredevops_project.project.id
  repository                    = var.selc-ms-notification-manager.repository
  github_service_connection_id  = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                          = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-ms-notification-manager.repository.name}"
  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selc-ms-notification-manager-variables,
    local.selc-ms-notification-manager-variables_code_review,
  )

  variables_secret = merge(
    local.selc-ms-notification-manager-variables_secret,
    local.selc-ms-notification-manager-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
    azuredevops_serviceendpoint_sonarcloud.sonarcloud.id,
  ]
}

module "selc-ms-notification-manager_deploy" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_deploy?ref=v6.0.0"
  count  = var.selc-ms-notification-manager.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selc-ms-notification-manager.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                         = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-ms-notification-manager.repository.name}"
  ci_trigger_use_yaml          = true

  variables = merge(
    local.selc-be-common-variables_deploy,
    local.selc-ms-notification-manager-variables,
    local.selc-ms-notification-manager-variables_deploy,
  )

  variables_secret = merge(
    local.selc-ms-notification-manager-variables_secret,
    local.selc-ms-notification-manager-variables_secret_deploy,
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
