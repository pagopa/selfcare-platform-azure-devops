variable "selfcare-assistance-frontend" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-assistance-frontend"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "pnpg"
    }
    pipeline = {
      enable_code_review = false
      enable_deploy      = true
      path               = "pnpg\\selfcare-assistance-frontend"
    }
  }
}

locals {
  # global vars
  selfcare-assistance-frontend-variables = {
    settings_xml_rw_secure_file_name = "settings-rw.xml"
    settings_xml_ro_secure_file_name = "settings-ro.xml"
    maven_remote_repo_server_id      = "selfcare-platform"
    maven_remote_repo                = "https://pkgs.dev.azure.com/pagopaspa/selfcare-platform-app-projects/_packaging/selfcare-platform/maven/v1"
    dockerfile                       = "Dockerfile"
  }
  # global secrets
  selfcare-assistance-frontend-variables_secret = {

  }
  # code_review vars
  selfcare-assistance-frontend-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.selfcare-assistance-frontend.repository.organization
    sonarcloud_project_key  = "${var.selfcare-assistance-frontend.repository.organization}_${var.selfcare-assistance-frontend.repository.name}"
    sonarcloud_project_name = var.selfcare-assistance-frontend.repository.name
  }
  # code_review secrets
  selfcare-assistance-frontend-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-assistance-frontend-variables_deploy = {

    K8S_IMAGE_REPOSITORY_NAME        = replace(var.selfcare-assistance-frontend.repository.name, "-", "")
    DEPLOY_NAMESPACE                 = local.domain
    DEPLOYMENT_NAME                  = "assistance-frontend"
    SETTINGS_XML_RW_SECURE_FILE_NAME = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME = "settings-ro.xml"
    HELM_RELEASE_NAME                = var.selfcare-assistance-frontend.repository.name

    DEV_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_dev_name
    DEV_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_dev
    DEV_CONTAINER_REGISTRY_NAME         = local.aks_dev_docker_registry_name
    DEV_AGENT_POOL                      = local.azdo_agent_pool_dev

    UAT_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_uat_name
    UAT_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_uat
    UAT_CONTAINER_REGISTRY_NAME         = local.aks_uat_docker_registry_name
    UAT_AGENT_POOL                      = local.azdo_agent_pool_uat

    PROD_CONTAINER_REGISTRY_SERVICE_CONN = local.service_endpoint_azure_devops_docker_prod_name
    PROD_KUBERNETES_SERVICE_CONN         = local.srv_endpoint_name_aks_prod
    PROD_CONTAINER_REGISTRY_NAME         = local.aks_prod_docker_registry_name
    PROD_AGENT_POOL                      = local.azdo_agent_pool_prod

  }
  # deploy secrets
  selfcare-assistance-frontend-variables_secret_deploy = {

  }
}

module "selfcare-assistance-frontend_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.selfcare-assistance-frontend.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-assistance-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  path                         = var.selfcare-assistance-frontend.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare-assistance-frontend-variables,
    local.selfcare-assistance-frontend-variables_code_review,
  )

  variables_secret = merge(
    local.selfcare-assistance-frontend-variables_secret,
    local.selfcare-assistance-frontend-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "selfcare-assistance-frontend_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-assistance-frontend.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-assistance-frontend.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id
  path                         = var.selfcare-assistance-frontend.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.selfcare-assistance-frontend-variables,
    local.selfcare-assistance-frontend-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-assistance-frontend-variables_secret,
    local.selfcare-assistance-frontend-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]
}
