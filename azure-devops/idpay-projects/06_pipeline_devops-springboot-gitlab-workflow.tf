variable "devops-springboot-gitlab-workflow" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "devops-springboot-gitlab-workflow"
      branch_name     = "release-dev"
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
  devops-springboot-gitlab-workflow-variables = {
    dockerfile = "Dockerfile"
  }
  # global secrets
  devops-springboot-gitlab-workflow-variables_secret = {

  }
  # code_review vars
  devops-springboot-gitlab-workflow-variables_code_review = {
    sonarcloud_service_conn = "SONARCLOUD-SERVICE-CONN"
    sonarcloud_org          = var.devops-springboot-gitlab-workflow.repository.organization
    sonarcloud_project_key  = "${var.devops-springboot-gitlab-workflow.repository.organization}_${var.devops-springboot-gitlab-workflow.repository.name}"
    sonarcloud_project_name = var.devops-springboot-gitlab-workflow.repository.name
  }
  # code_review secrets
  devops-springboot-gitlab-workflow-variables_secret_code_review = {

  }
  # deploy vars
  devops-springboot-gitlab-workflow-variables_deploy = {
    K8S_IMAGE_REPOSITORY_NAME            = replace(var.devops-springboot-gitlab-workflow.repository.name, "-", "")
    DEPLOY_NAMESPACE                     = local.domain
    SETTINGS_XML_RW_SECURE_FILE_NAME     = "settings-rw.xml"
    SETTINGS_XML_RO_SECURE_FILE_NAME     = "settings-ro.xml"
    HELM_RELEASE_NAME = var.devops-springboot-gitlab-workflow.repository.name

    DEV_CONTAINER_REGISTRY_SERVICE_CONN  = local.service_endpoint_azure_devops_acr_aks_dev_name
    DEV_KUBERNETES_SERVICE_CONN          = local.srv_endpoint_name_aks_dev
    DEV_CONTAINER_REGISTRY_NAME          = local.aks_cr_name_dev
    DEV_AGENT_POOL                       = local.azdo_agent_pool_dev
    # UAT_CONTAINER_REGISTRY_SERVICE_CONN  = azuredevops_serviceendpoint_azurecr.cstar-azurecr-uat.service_endpoint_name
    # UAT_KUBERNETES_SERVICE_CONN          = azuredevops_serviceendpoint_kubernetes.cstar-aks-uat.service_endpoint_name
    # UAT_CONTAINER_REGISTRY_NAME          = "cstaruacr.azurecr.io"
    # UAT_AGENT_POOL                       = "cstar-uat-linux"
    # PROD_CONTAINER_REGISTRY_SERVICE_CONN = azuredevops_serviceendpoint_azurecr.cstar-azurecr-prod.service_endpoint_name
    # PROD_KUBERNETES_SERVICE_CONN         = azuredevops_serviceendpoint_kubernetes.cstar-aks-prod.service_endpoint_name
    # PROD_CONTAINER_REGISTRY_NAME         = "cstarpacr.azurecr.io"
    # PROD_AGENT_POOL                      = "cstar-prod-linux"
  }
  # deploy secrets
  devops-springboot-gitlab-workflow-variables_secret_deploy = {

  }
}

# module "devops-springboot-gitlab-workflow_code_review" {
#   source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_code_review?ref=v2.1.0"
#   count  = var.devops-springboot-gitlab-workflow.pipeline.enable_code_review == true ? 1 : 0

#   project_id                   = azuredevops_project.project.id
#   repository                   = var.devops-springboot-gitlab-workflow.repository
#   github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id

#   pull_request_trigger_use_yaml = true

#   variables = merge(
#     local.devops-springboot-gitlab-workflow-variables,
#     local.devops-springboot-gitlab-workflow-variables_code_review,
#   )

#   variables_secret = merge(
#     local.devops-springboot-gitlab-workflow-variables_secret,
#     local.devops-springboot-gitlab-workflow-variables_secret_code_review,
#   )

#   service_connection_ids_authorization = [
#     azuredevops_serviceendpoint_github.io-azure-devops-github-ro.id,
#     local.azuredevops_serviceendpoint_sonarcloud_id,
#   ]
# }

module "devops-springboot-gitlab-workflow_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.1.0"
  count  = var.devops-springboot-gitlab-workflow.pipeline.enable_deploy == true ? 1 : 0

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.devops-springboot-gitlab-workflow.repository
  github_service_connection_id = local.service_endpoint_io_azure_devops_github_pr_id

  ci_trigger_use_yaml = true

  variables = merge(
    local.devops-springboot-gitlab-workflow-variables,
    local.devops-springboot-gitlab-workflow-variables_deploy,
  )

  variables_secret = merge(
    local.devops-springboot-gitlab-workflow-variables_secret,
    local.devops-springboot-gitlab-workflow-variables_secret_deploy,
  )

  service_connection_ids_authorization = [
    local.service_endpoint_io_azure_devops_github_pr_id,

    local.service_endpoint_azure_dev_id,
    local.service_endpoint_azure_devops_acr_aks_dev_id,
    azuredevops_serviceendpoint_kubernetes.aks_dev.id
  ]
}
