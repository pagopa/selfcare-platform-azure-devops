variable "hub-spid-login-ms" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "hub-spid-login-ms"
      branch_name     = "master"
      pipelines_path  = ".devops/kubernetes"
      yml_prefix_name = null
    }
    pipeline = {
      enable_deploy = true
    }
  }
}

locals {
  # global vars
  hub-spid-login-ms-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  hub-spid-login-ms-variables_secret = {

  }
  # code_review vars
  hub-spid-login-ms-variables_code_review = {

  }
  # code_review secrets
  hub-spid-login-ms-variables_secret_code_review = {

  }
  # deploy vars
  hub-spid-login-ms-variables_deploy = {
    k8s_image_repository_name = replace(var.hub-spid-login-ms.repository.name, "-", "")
    deploy_namespace          = "selc"
    dev_replicas              = 2
    uat_replicas              = 2
    prod_replicas             = 2
  }
  # deploy secrets
  hub-spid-login-ms-variables_secret_deploy = {

  }
}

module "hub-spid-login-ms_deploy" {
  source = "github.com/pagopa/azuredevops-tf-modules//azuredevops_build_definition_deploy?ref=v6.0.0"
  count  = var.hub-spid-login-ms.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.hub-spid-login-ms.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.id
  path                         = "${local.selfcare_legacy.pipelines_folder_name}\\${var.hub-spid-login-ms.repository.name}"
  ci_trigger_use_yaml          = true

  variables = merge(
    local.selc-be-common-variables_deploy,
    local.hub-spid-login-ms-variables,
    local.hub-spid-login-ms-variables_deploy,
  )

  variables_secret = merge(
    local.hub-spid-login-ms-variables_secret,
    local.hub-spid-login-ms-variables_secret_deploy,
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
