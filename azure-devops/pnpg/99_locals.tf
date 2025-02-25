locals {

  #CORE


  #KV
  dev_key_vault_name  = "selc-d-pnpg-kv"
  uat_key_vault_name  = "selc-u-pnpg-kv"
  prod_key_vault_name = "selc-p-pnpg-kv"

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

    uat_azure_subscription = data.azuredevops_serviceendpoint_azurerm.azure_uat.service_endpoint_id
    uat_cdn_endpoint       = "selc-u-weu-pnpg-checkout-cdn-endpoint"
    uat_cdn_profile        = "selc-u-weu-pnpg-checkout-cdn-profile"
    uat_resource_group     = "selc-u-weu-pnpg-checkout-fe-rg"
    uat_storage_account    = "selcuweupnpgcheckoutsa"
    uat_analytics_enabled  = "true"
    uat_analytics_mocked   = "false"
    uat_mixpanel_token     = "6e1290bdda5885981a2f443f37444f0f"
    uat_onetrust_domain_id = "15a1f042-9257-450f-b9e8-38d019191729"

    prod_azure_subscription = data.azuredevops_serviceendpoint_azurerm.azure_prod.service_endpoint_id
    prod_cdn_endpoint       = "selc-p-weu-pnpg-checkout-cdn-endpoint"
    prod_cdn_profile        = "selc-p-weu-pnpg-checkout-cdn-profile"
    prod_resource_group     = "selc-p-weu-pnpg-checkout-fe-rg"
    prod_storage_account    = "selcpweupnpgcheckoutsa"
    prod_analytics_enabled  = "true"
    prod_analytics_mocked   = "false"
    prod_mixpanel_token     = "1d1b09b008638080ab34fe9b75db84fd"
    prod_onetrust_domain_id = "084d5de2-d423-458a-9b28-0f8db3e55e71"

    react_app_assistance_email = "destinatari-send@assistenza.pagopa.it"

    react_app_ot_src                      = "https://privacyportalde-cdn.onetrust.com/privacy-notice-scripts/otnotice-1.0.min.js"
    react_app_ot_token                    = "eyJjYWxsYmFja1VybCI6Imh0dHBzOi8vcHJpdmFjeXBvcnRhbC1kZS5vbmV0cnVzdC5jb20vcmVxdWVzdC92MS9wcml2YWN5Tm90aWNlcy9zdGF0cy92aWV3cyJ9"
    react_app_ot_terms_condition_resource = "https://privacyportalde-cdn.onetrust.com/77f17844-04c3-4969-a11d-462ee77acbe1/privacy-notices/6f92cced-3bd1-4859-9295-baecfc74c64a.json"
    react_app_ot_tos_resource             = "https://privacyportalde-cdn.onetrust.com/77f17844-04c3-4969-a11d-462ee77acbe1/privacy-notices/26403d01-dc46-4c89-be70-4894839cf639.json"

    dev_react_app_url_cdn                  = "https://pnpg.dev.selfcare.pagopa.it"
    dev_react_app_url_storage              = "https://selcdweupnpgcheckoutsa.z6.web.core.windows.net"
    dev_react_app_products_asset           = "https://pnpg.dev.selfcare.pagopa.it/assets/products.json"
    dev_react_app_login_alert_banner       = "https://pnpg.dev.selfcare.pagopa.it/assets/login-alert-message.json"
    dev_react_app_login_spid_enabled       = "false"
    dev_react_app_url_privacy_disclaimer   = "https://imprese.dev.notifichedigitali.it/informativa-privacy"
    dev_react_app_url_terms_and_conditions = "https://imprese.dev.notifichedigitali.it/termini-di-servizio"
    dev_react_app_url_fe_login             = "https://pnpg.dev.selfcare.pagopa.it/auth"
    dev_react_app_url_fe_onboarding        = "https://pnpg.dev.selfcare.pagopa.it/onboarding"
    dev_react_app_url_fe_onboarding-pnpg   = "https://pnpg.dev.selfcare.pagopa.it/onboarding-pnpg"
    dev_react_app_url_fe_dashboard         = "https://pnpg.dev.selfcare.pagopa.it/dashboard"
    dev_react_app_url_fe_dashboard_admin   = "https://pnpg.dev.selfcare.pagopa.it/microcomponents/dashboard/admin"
    dev_react_app_url_fe_dashboard_users   = "https://pnpg.dev.selfcare.pagopa.it/microcomponents/dashboard/users"
    dev_react_app_enable_user_v2           = "true"
    dev_react_app_enable_mobile_phone      = "true"
    dev_react_app_max_admin_count          = 3
    dev_react_app_url_fe_dashboard_groups  = "https://pnpg.dev.selfcare.pagopa.it/microcomponents/dashboard/groups"
    dev_react_app_url_fe_assistance        = "https://pnpg.dev.selfcare.pagopa.it/assistenza"
    dev_react_app_url_fe_landing           = "https://pnpg.dev.selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    dev_react_app_url_fe_token_exchange    = "https://pnpg.dev.selfcare.pagopa.it/token-exchange"

    dev_react_app_url_api_login                = "https://api-pnpg.dev.selfcare.pagopa.it/spid/v1"
    dev_react_app_url_api_party_registry_proxy = "https://api-pnpg.dev.selfcare.pagopa.it/imprese/party-registry-proxy/v1"
    dev_react_app_url_api_dashboard            = "https://api-pnpg.dev.selfcare.pagopa.it/imprese/dashboard"
    dev_react_app_url_api_onboarding           = "https://api-pnpg.dev.selfcare.pagopa.it/imprese/onboarding/v1"
    dev_react_app_url_api_onboarding_v2        = "https://api-pnpg.dev.selfcare.pagopa.it/imprese/onboarding"

    uat_react_app_url_cdn                      = "https://imprese.uat.notifichedigitali.it"
    uat_react_app_url_storage                  = "https://selcuweupnpgcheckoutsa.z6.web.core.windows.net"
    uat_react_app_products_asset               = "https://imprese.uat.notifichedigitali.it/assets/products.json"
    uat_react_app_login_alert_banner           = "https://pnpg.uat.selfcare.pagopa.it/assets/login-alert-message.json"
    uat_react_app_login_spid_enabled           = "false"
    uat_react_app_url_privacy_disclaimer       = "https://imprese.uat.notifichedigitali.it/informativa-privacy"
    uat_react_app_url_terms_and_conditions     = "https://imprese.uat.notifichedigitali.it/termini-di-servizio"
    uat_react_app_url_fe_login                 = "https://imprese.uat.notifichedigitali.it/auth"
    uat_react_app_url_fe_onboarding            = "https://imprese.uat.notifichedigitali.it/onboarding"
    uat_react_app_url_fe_dashboard             = "https://imprese.uat.notifichedigitali.it/dashboard"
    uat_react_app_url_fe_onboarding-pnpg       = "https://imprese.uat.notifichedigitali.it/onboarding-pnpg"
    uat_react_app_url_fe_dashboard_admin       = "https://imprese.uat.notifichedigitali.it/microcomponents/dashboard/admin"
    uat_react_app_url_fe_dashboard_users       = "https://imprese.uat.notifichedigitali.it/microcomponents/dashboard/users"
    uat_react_app_enable_user_v2               = "true"
    uat_react_app_enable_mobile_phone          = "true"
    uat_react_app_max_admin_count              = 3
    uat_react_app_url_fe_dashboard_groups      = "https://imprese.uat.notifichedigitali.it/microcomponents/dashboard/groups"
    uat_react_app_url_fe_assistance            = "https://imprese.uat.notifichedigitali.it/assistenza"
    uat_react_app_url_fe_landing               = "https://imprese.uat.notifichedigitali.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    uat_react_app_url_fe_token_exchange        = "https://imprese.uat.notifichedigitali.it/token-exchange"
    uat_react_app_url_api_login                = "https://api-pnpg.uat.selfcare.pagopa.it/spid/v1"
    uat_react_app_url_api_party_registry_proxy = "https://api-pnpg.uat.selfcare.pagopa.it/imprese/party-registry-proxy/v1"
    uat_react_app_url_api_dashboard            = "https://api-pnpg.uat.selfcare.pagopa.it/imprese/dashboard"
    uat_react_app_url_api_onboarding           = "https://api-pnpg.uat.selfcare.pagopa.it/imprese/onboarding/v1"
    uat_react_app_url_api_onboarding_v2        = "https://api-pnpg.uat.selfcare.pagopa.it/imprese/onboarding"

    prod_react_app_url_cdn                      = "https://imprese.notifichedigitali.it"
    prod_react_app_url_storage                  = "https://selcpweupnpgcheckoutsa.z6.web.core.windows.net"
    prod_react_app_products_asset               = "https://imprese.notifichedigitali.it/assets/products.json"
    prod_react_app_login_alert_banner           = "https://pnpg.selfcare.pagopa.it/assets/login-alert-message.json"
    prod_react_app_login_spid_enabled           = "false"
    prod_react_app_url_privacy_disclaimer       = "https://imprese.notifichedigitali.it/informativa-privacy"
    prod_react_app_url_terms_and_conditions     = "https://imprese.notifichedigitali.it/termini-di-servizio"
    prod_react_app_url_fe_login                 = "https://imprese.notifichedigitali.it/auth"
    prod_react_app_url_fe_onboarding            = "https://imprese.notifichedigitali.it/onboarding"
    prod_react_app_url_fe_dashboard             = "https://imprese.notifichedigitali.it/dashboard"
    prod_react_app_url_fe_onboarding-pnpg       = "https://imprese.notifichedigitali.it/onboarding-pnpg"
    prod_react_app_url_fe_dashboard_admin       = "https://imprese.notifichedigitali.it/microcomponents/dashboard/admin"
    prod_react_app_url_fe_dashboard_users       = "https://imprese.notifichedigitali.it/microcomponents/dashboard/users"
    prod_react_app_enable_user_v2               = "true"
    prod_react_app_enable_mobile_phone          = "true"
    prod_react_app_max_admin_count              = 3
    prod_react_app_url_fe_dashboard_groups      = "https://imprese.notifichedigitali.it/microcomponents/dashboard/groups"
    prod_react_app_url_fe_assistance            = "https://imprese.notifichedigitali.it/assistenza"
    prod_react_app_url_fe_landing               = "https://imprese.notifichedigitali.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    prod_react_app_url_fe_token_exchange        = "https://imprese.notifichedigitali.it/token-exchange"
    prod_react_app_url_api_login                = "https://api-pnpg.selfcare.pagopa.it/spid/v1"
    prod_react_app_url_api_party_registry_proxy = "https://api-pnpg.selfcare.pagopa.it/imprese/party-registry-proxy/v1"
    prod_react_app_url_api_dashboard            = "https://api-pnpg.selfcare.pagopa.it/imprese/dashboard"
    prod_react_app_url_api_onboarding           = "https://api-pnpg.selfcare.pagopa.it/imprese/onboarding/v1"
    prod_react_app_url_api_onboarding_v2        = "https://api-pnpg.selfcare.pagopa.it/imprese/onboarding"
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
