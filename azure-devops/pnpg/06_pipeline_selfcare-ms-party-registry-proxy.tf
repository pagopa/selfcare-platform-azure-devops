variable "selfcare-ms-party-registry-proxy" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-ms-party-registry-proxy"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "pnpg"
    }
    pipeline = {
      enable_code_review = true
      enable_deploy      = true
      path               = "pnpg\\selfcare-ms-party-registry-proxy"
    }
  }
}

locals {
  # global vars
  selfcare-ms-party-registry-proxy-variables = {
    settings_xml_rw_secure_file_name = "settings-rw.xml"
    settings_xml_ro_secure_file_name = "settings-ro.xml"
    maven_remote_repo_server_id      = "selfcare-platform"
    maven_remote_repo                = "https://pkgs.dev.azure.com/pagopaspa/selfcare-platform-app-projects/_packaging/selfcare-platform/maven/v1"
    dockerfile                       = "Dockerfile"
  }
  # global secrets
  selfcare-ms-party-registry-proxy-variables_secret = {

  }
  # code_review vars
  selfcare-ms-party-registry-proxy-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.selfcare-ms-party-registry-proxy.repository.organization
    sonarcloud_project_key  = "${var.selfcare-ms-party-registry-proxy.repository.organization}_${var.selfcare-ms-party-registry-proxy.repository.name}"
    sonarcloud_project_name = var.selfcare-ms-party-registry-proxy.repository.name
  }
  # code_review secrets
  selfcare-ms-party-registry-proxy-variables_secret_code_review = {

  }
  # deploy vars
  selfcare-ms-party-registry-proxy-variables_deploy = {
    k8s_image_repository_name = replace(var.selfcare-ms-party-registry-proxy.repository.name, "-", "")
    deploy_namespace          = local.domain
    deployment_name           = "ms-party-registry-proxy"
    helm_release_name         = var.selfcare-ms-party-registry-proxy.repository.name
  }
  # deploy secrets
  selfcare-ms-party-registry-proxy-variables_secret_deploy = {

  }
}

module "selfcare-ms-party-registry-proxy_code_review" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.6.5"
  count  = var.selfcare-ms-party-registry-proxy.pipeline.enable_code_review == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-ms-party-registry-proxy.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-ms-party-registry-proxy.pipeline.path

  pull_request_trigger_use_yaml = true

  variables = merge(
    local.selfcare-ms-party-registry-proxy-variables,
    local.selfcare-ms-party-registry-proxy-variables_code_review,
  )

  variables_secret = merge(
    local.selfcare-ms-party-registry-proxy-variables_secret,
    local.selfcare-ms-party-registry-proxy-variables_secret_code_review,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    local.azuredevops_serviceendpoint_sonarcloud_id,
  ]
}

module "selfcare-ms-party-registry-proxy_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.5"
  count  = var.selfcare-ms-party-registry-proxy.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selfcare-ms-party-registry-proxy.repository
  github_service_connection_id = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id
  path                         = var.selfcare-ms-party-registry-proxy.pipeline.path

  ci_trigger_use_yaml = true

  variables = merge(
    local.pnpg-be-common-variables_deploy,
    local.selfcare-ms-party-registry-proxy-variables,
    local.selfcare-ms-party-registry-proxy-variables_deploy,
  )

  variables_secret = merge(
    local.selfcare-ms-party-registry-proxy-variables_secret,
    local.selfcare-ms-party-registry-proxy-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    data.azuredevops_serviceendpoint_github.github_ro.service_endpoint_id,
    data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id,
    local.service_endpoint_azure_devops_docker_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]
}
