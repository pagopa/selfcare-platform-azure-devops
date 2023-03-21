locals {
  
  #CORE
  

  #KV
  dev_key_vault_name           = "selc-d-pnpg-kv"
  uat_key_vault_name           = "selc-u-pnpg-kv"
  prod_key_vault_name          = "selc-p-pnpg-kv"
  
  # Subscription Name
  dev_selfcare_subscription_name  = "dev-selfcare"
  uat_selfcare_subscription_name  = "uat-selfcare"
  prod_selfcare_subscription_name = "prod-selfcare"



  selfcare_legacy = {
    pipelines_folder_name = "pnpg"
  }

  selc-fe-common-variables_deploy-pnpg = {
    blob_container_name = "$web"

    git_mail          = module.secrets_core_prod.values["io-azure-devops-github-EMAIL"].value
    git_username      = module.secrets_core_prod.values["io-azure-devops-github-USERNAME"].value
    github_connection = data.azuredevops_serviceendpoint_github.github_rw.service_endpoint_id

    dev_azure_subscription = data.azuredevops_serviceendpoint_azurerm.azure_dev.service_endpoint_id
    dev_cdn_endpoint       = "selc-d-weu-pnpg-checkout-cdn-endpoint"
    dev_cdn_profile        = "selc-d-weu-pnpg-checkout-cdn-profile"
    dev_resource_group     = "selc-d-weu-pnpg-checkout-fe-rg"
    dev_storage_account    = "selcdweupnpgcheckoutsa"
    dev_analytics_enabled  = "true"
    dev_analytics_mocked   = "false"
    dev_mixpanel_token     = "6e1290bdda5885981a2f443f37444f0f"
    dev_onetrust_domain_id = "a8f58d7a-7f6a-4fe6-ac02-f95bac3876d4-test"

    # uat_azure_subscription = azuredevops_serviceendpoint_azurerm.UAT-SELFCARE.service_endpoint_name
    # uat_cdn_endpoint       = "selc-u-checkout-cdn-endpoint"
    # uat_cdn_profile        = "selc-u-checkout-cdn-profile"
    # uat_resource_group     = "selc-u-checkout-fe-rg"
    # uat_storage_account    = "selcucheckoutsa"
    # uat_analytics_enabled  = "true"
    # uat_analytics_mocked   = "false"
    # uat_mixpanel_token     = "6e1290bdda5885981a2f443f37444f0f"
    # uat_onetrust_domain_id = "15a1f042-9257-450f-b9e8-38d019191729"

    # prod_azure_subscription = azuredevops_serviceendpoint_azurerm.PROD-SELFCARE.service_endpoint_name
    # prod_cdn_endpoint       = "selc-p-checkout-cdn-endpoint"
    # prod_cdn_profile        = "selc-p-checkout-cdn-profile"
    # prod_resource_group     = "selc-p-checkout-fe-rg"
    # prod_storage_account    = "selcpcheckoutsa"
    # prod_analytics_enabled  = "true"
    # prod_analytics_mocked   = "false"
    # prod_mixpanel_token     = "1d1b09b008638080ab34fe9b75db84fd"
    # prod_onetrust_domain_id = "084d5de2-d423-458a-9b28-0f8db3e55e71"

    react_app_assistance_email = "selfcare@assistenza.pagopa.it"

    dev_react_app_url_cdn                      = "https://pnpg.dev.selfcare.pagopa.it"
    dev_react_app_url_storage                  = "https://selcdweupnpgcheckoutsa.z6.web.core.windows.net"
    dev_react_app_url_fe_login                 = "https://pnpg.dev.selfcare.pagopa.it/auth"
    dev_react_app_url_fe_onboarding            = "https://pnpg.dev.selfcare.pagopa.it/onboarding"
    dev_react_app_url_fe_onboarding-pnpg       = "https://pnpg.dev.selfcare.pagopa.it/onboarding-pnpg"
    dev_react_app_url_fe_dashboard             = "https://pnpg.dev.selfcare.pagopa.it/dashboard"
    dev_react_app_url_fe_dashboard_admin       = "https://pnpg.dev.selfcare.pagopa.it/microcomponents/dashboard/admin"
    dev_react_app_url_fe_dashboard_users       = "https://pnpg.dev.selfcare.pagopa.it/microcomponents/dashboard/users"
    dev_react_app_url_fe_dashboard_groups      = "https://pnpg.dev.selfcare.pagopa.it/microcomponents/dashboard/groups"
    dev_react_app_url_fe_assistance            = "https://pnpg.dev.selfcare.pagopa.it/assistenza"
    dev_react_app_url_fe_landing               = "https://pnpg.dev.selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    dev_react_app_url_fe_token_exchange        = "https://pnpg.dev.selfcare.pagopa.it/token-exchange"
    dev_react_app_url_api_login                = "https://api-pnpg.dev.selfcare.pagopa.it/pnpg/spid/v1"
    dev_react_app_url_api_party_process        = "https://api-pnpg.dev.selfcare.pagopa.it/pnpg/party-process/v1"
    dev_react_app_url_api_party_management     = "https://api-pnpg.dev.selfcare.pagopa.it/pnpg/party-management/v1"
    dev_react_app_url_api_party_registry_proxy = "https://api-pnpg.dev.selfcare.pagopa.it/pnpg/party-registry-proxy/v1"
    dev_react_app_url_api_dashboard            = "https://api-pnpg.dev.selfcare.pagopa.it/pnpg/dashboard/v1"
    dev_react_app_url_api_onboarding           = "https://api-pnpg.dev.selfcare.pagopa.it/pnpg/onboarding/v1"
    dev_react_app_url_api_notification         = "https://api-pnpg.dev.selfcare.pagopa.it/pnpg/ms-notification-manager"

    # uat_react_app_url_cdn                      = "https://uat.selfcare.pagopa.it"
    # uat_react_app_url_storage                  = "https://selcucheckoutsa.z6.web.core.windows.net"
    # uat_react_app_url_fe_login                 = "https://uat.selfcare.pagopa.it/auth"
    # uat_react_app_url_fe_onboarding            = "https://uat.selfcare.pagopa.it/onboarding"
    # uat_react_app_url_fe_dashboard             = "https://uat.selfcare.pagopa.it/dashboard"
    # uat_react_app_url_fe_onboarding-pnpg       = "https://uat.selfcare.pagopa.it/onboarding-pnpg"
    # uat_react_app_url_fe_dashboard_admin       = "https://uat.selfcare.pagopa.it/microcomponents/dashboard/admin"
    # uat_react_app_url_fe_dashboard_users       = "https://uat.selfcare.pagopa.it/microcomponents/dashboard/users"
    # uat_react_app_url_fe_dashboard_groups      = "https://uat.selfcare.pagopa.it/microcomponents/dashboard/groups"
    # uat_react_app_url_fe_assistance            = "https://uat.selfcare.pagopa.it/assistenza"
    # uat_react_app_url_fe_landing               = "https://uat.selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    # uat_react_app_url_fe_token_exchange        = "https://uat.selfcare.pagopa.it/token-exchange"
    # uat_react_app_url_api_login                = "https://api.uat.selfcare.pagopa.it/spid/v1"
    # uat_react_app_url_api_party_process        = "https://api.uat.selfcare.pagopa.it/party-process/v1"
    # uat_react_app_url_api_party_management     = "https://api.uat.selfcare.pagopa.it/party-management/v1"
    # uat_react_app_url_api_party_registry_proxy = "https://api.uat.selfcare.pagopa.it/party-registry-proxy/v1"
    # uat_react_app_url_api_dashboard            = "https://api.uat.selfcare.pagopa.it/dashboard/v1"
    # uat_react_app_url_api_onboarding           = "https://api.uat.selfcare.pagopa.it/onboarding/v1"
    # uat_react_app_url_api_notification         = "https://api.uat.selfcare.pagopa.it/ms-notification-manager"

    # prod_react_app_url_cdn                      = "https://selfcare.pagopa.it"
    # prod_react_app_url_storage                  = "https://selcpcheckoutsa.z6.web.core.windows.net"
    # prod_react_app_url_fe_login                 = "https://selfcare.pagopa.it/auth"
    # prod_react_app_url_fe_onboarding            = "https://selfcare.pagopa.it/onboarding"
    # prod_react_app_url_fe_dashboard             = "https://selfcare.pagopa.it/dashboard"
    # prod_react_app_url_fe_onboarding-pnpg       = "https://selfcare.pagopa.it/onboarding-pnpg"
    # prod_react_app_url_fe_dashboard_admin       = "https://selfcare.pagopa.it/microcomponents/dashboard/admin"
    # prod_react_app_url_fe_dashboard_users       = "https://selfcare.pagopa.it/microcomponents/dashboard/users"
    # prod_react_app_url_fe_dashboard_groups      = "https://selfcare.pagopa.it/microcomponents/dashboard/groups"
    # prod_react_app_url_fe_assistance            = "https://selfcare.pagopa.it/assistenza"
    # prod_react_app_url_fe_landing               = "https://selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    # prod_react_app_url_fe_token_exchange        = "https://selfcare.pagopa.it/token-exchange"
    # prod_react_app_url_api_login                = "https://api.selfcare.pagopa.it/spid/v1"
    # prod_react_app_url_api_party_process        = "https://api.selfcare.pagopa.it/party-process/v1"
    # prod_react_app_url_api_party_management     = "https://api.selfcare.pagopa.it/party-management/v1"
    # prod_react_app_url_api_party_registry_proxy = "https://api.selfcare.pagopa.it/party-registry-proxy/v1"
    # prod_react_app_url_api_dashboard            = "https://api.selfcare.pagopa.it/dashboard/v1"
    # prod_react_app_url_api_onboarding           = "https://api.selfcare.pagopa.it/onboarding/v1"
    # prod_react_app_url_api_notification         = "https://api.selfcare.pagopa.it/ms-notification-manager"

  }

  pnpg-be-common-variables_deploy = {
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


}
