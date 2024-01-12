variable "selc-proxy-mockserver" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "selfcare-proxy-mockserver"
      branch_name     = "refs/heads/master"
      pipelines_path  = ".devops"
      yml_prefix_name = null
    }
    pipeline = {
      enable_code_review = false
      enable_deploy      = true
    }
  }
}

locals {
  # global vars
  selc-proxy-mockserver-variables = {
    docker_base_image_name = "hub.docker.com/r/mockserver/mockserver"
    dockerfile             = "Dockerfile"
  }
  # global secrets
  selc-proxy-mockserver-variables_secret = {

  }
  # code_review vars
  selc-proxy-mockserver-variables_code_review = {

  }
  # code_review secrets
  selc-proxy-mockserver-variables_secret_code_review = {

  }
  # deploy vars
  selc-proxy-mockserver-variables_deploy = {
    k8s_image_repository_name = replace(var.selc-proxy-mockserver.repository.name, "-", "")
    deploy_namespace          = "selc"
    deployment_name           = "mockserver"
  }
  # deploy secrets
  selc-proxy-mockserver-variables_secret_deploy = {

  }
}

module "selc-proxy-mockserver_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v4.1.1"
  count  = var.selc-proxy-mockserver.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.selc-proxy-mockserver.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id
  path                         = "${local.selfcare_legacy.pipelines_folder_name}\\${var.selc-proxy-mockserver.repository.name}"
  ci_trigger_use_yaml          = true

  variables = merge(
    local.selc-be-common-variables_deploy,
    local.selc-proxy-mockserver-variables,
    local.selc-proxy-mockserver-variables_deploy,
  )

  variables_secret = merge(
    local.selc-proxy-mockserver-variables_secret,
    local.selc-proxy-mockserver-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id,
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
