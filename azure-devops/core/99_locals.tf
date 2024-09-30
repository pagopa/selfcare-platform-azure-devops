locals {
  prefix   = "selc"
  location = "westeurope"

  organization         = "pagopa"
  acme_repository_name = "le-azure-acme-tiny"
  master_branch_ref    = "refs/heads/master"

  #RG
  dev_resource_group_name  = "${local.prefix}-d-identity-rg"
  uat_resource_group_name  = "${local.prefix}-u-identity-rg"
  prod_resource_group_name = "${local.prefix}-p-identity-rg"

  #CORE
  core_key_vault_name              = "selc-p-kv"
  core_key_vault_resource_group    = "selc-p-sec-rg"
  core_key_vault_subscription_name = "PROD-SELFCARE"

  #VNET
  dev_vnet_name                = "selc-d-vnet"
  dev_vnet_resource_group_name = "selc-d-vnet-rg"

  uat_vnet_name                = "selc-u-vnet"
  uat_vnet_resource_group_name = "selc-u-vnet-rg"

  prod_vnet_name                = "selc-p-vnet"
  prod_vnet_resource_group_name = "selc-p-vnet-rg"

  #KV
  dev_key_vault_name           = "selc-d-kv"
  dev_key_vault_resource_group = "selc-d-sec-rg"

  uat_key_vault_name           = "selc-u-kv"
  uat_key_vault_resource_group = "selc-u-sec-rg"

  prod_key_vault_name           = "selc-p-kv"
  prod_key_vault_resource_group = "selc-p-sec-rg"

  # Subscription Name
  dev_selfcare_subscription_name  = "dev-selfcare"
  uat_selfcare_subscription_name  = "uat-selfcare"
  prod_selfcare_subscription_name = "prod-selfcare"

  # Agent Pool
  azdo_agent_pool_dev  = "selfcare-dev-linux"
  azdo_agent_pool_uat  = "selfcare-uat-linux"
  azdo_agent_pool_prod = "selfcare-prod-linux"

  #tfsec:ignore:GEN002
  tlscert_renew_token = "v2"

  selfcare_legacy = {
    pipelines_folder_name = "selfcare_legacy"
  }

  selc-fe-common-variables_deploy = {
    blob_container_name = "$web"

    git_mail          = module.secrets.values["io-azure-devops-github-EMAIL"].value
    git_username      = module.secrets.values["io-azure-devops-github-USERNAME"].value
    github_connection = azuredevops_serviceendpoint_github.io-azure-devops-github-rw.service_endpoint_name

    dev_azure_subscription        = azuredevops_serviceendpoint_azurerm.DEV-SELFCARE.service_endpoint_name
    dev_cdn_endpoint              = "selc-d-checkout-cdn-endpoint"
    dev_cdn_profile               = "selc-d-checkout-cdn-profile"
    dev_resource_group            = "selc-d-checkout-fe-rg"
    dev_storage_account           = "selcdcheckoutsa"
    dev_analytics_enabled         = "true"
    dev_analytics_mocked          = "false"
    dev_mixpanel_token            = "6e1290bdda5885981a2f443f37444f0f"
    dev_onetrust_domain_id        = "a8f58d7a-7f6a-4fe6-ac02-f95bac3876d4-test"
    dev_react_app_url_geotaxonomy = "https://api.pdnd.pagopa.it/geo-tax/geotaxonomy"
    dev_aoo_uo_enabled            = "true"
    dev_pt_enabled                = "true"
    dev_delegations_enabled       = "true"
    dev_aggregator_enabled        = "true"
    dev_scp_infocamere_enabled    = "true"
    dev_prv_enabled               = "true"
    dev_pure_prv_enabled          = "true"

    uat_azure_subscription        = azuredevops_serviceendpoint_azurerm.UAT-SELFCARE.service_endpoint_name
    uat_cdn_endpoint              = "selc-u-checkout-cdn-endpoint"
    uat_cdn_profile               = "selc-u-checkout-cdn-profile"
    uat_resource_group            = "selc-u-checkout-fe-rg"
    uat_storage_account           = "selcucheckoutsa"
    uat_analytics_enabled         = "true"
    uat_analytics_mocked          = "false"
    uat_mixpanel_token            = "6e1290bdda5885981a2f443f37444f0f"
    uat_onetrust_domain_id        = "15a1f042-9257-450f-b9e8-38d019191729"
    uat_react_app_url_geotaxonomy = "https://api.pdnd.pagopa.it/geo-tax/geotaxonomy"
    uat_aoo_uo_enabled            = "true"
    uat_pt_enabled                = "false"
    uat_delegations_enabled       = "true"
    uat_aggregator_enabled        = "true"
    uat_scp_infocamere_enabled    = "true"
    uat_prv_enabled               = "true"
    uat_pure_prv_enabled          = "true"

    prod_azure_subscription        = azuredevops_serviceendpoint_azurerm.PROD-SELFCARE.service_endpoint_name
    prod_cdn_endpoint              = "selc-p-checkout-cdn-endpoint"
    prod_cdn_profile               = "selc-p-checkout-cdn-profile"
    prod_resource_group            = "selc-p-checkout-fe-rg"
    prod_storage_account           = "selcpcheckoutsa"
    prod_analytics_enabled         = "true"
    prod_analytics_mocked          = "false"
    prod_mixpanel_token            = "1d1b09b008638080ab34fe9b75db84fd"
    prod_onetrust_domain_id        = "084d5de2-d423-458a-9b28-0f8db3e55e71"
    prod_react_app_url_geotaxonomy = "https://api.pdnd.pagopa.it/geo-tax/geotaxonomy"
    prod_aoo_uo_enabled            = "true"
    prod_pt_enabled                = "false"
    prod_delegations_enabled       = "true"
    prod_aggregator_enabled        = "false"
    prod_scp_infocamere_enabled    = "true"
    prod_prv_enabled               = "false"
    prod_pure_prv_enabled          = "false"

    react_app_assistance_email = "areariservata@assistenza.pagopa.it"

    react_app_ot_src                      = "https://privacyportalde-cdn.onetrust.com/privacy-notice-scripts/otnotice-1.0.min.js"
    react_app_ot_token                    = "eyJjYWxsYmFja1VybCI6Imh0dHBzOi8vcHJpdmFjeXBvcnRhbC1kZS5vbmV0cnVzdC5jb20vcmVxdWVzdC92MS9wcml2YWN5Tm90aWNlcy9zdGF0cy92aWV3cyJ9"
    react_app_ot_terms_condition_resource = "https://privacyportalde-cdn.onetrust.com/77f17844-04c3-4969-a11d-462ee77acbe1/privacy-notices/6f92cced-3bd1-4859-9295-baecfc74c64a.json"
    react_app_ot_tos_resource             = "https://privacyportalde-cdn.onetrust.com/77f17844-04c3-4969-a11d-462ee77acbe1/privacy-notices/26403d01-dc46-4c89-be70-4894839cf639.json"

    dev_react_app_url_cdn                  = "https://dev.selfcare.pagopa.it"
    dev_react_app_url_storage              = "https://selcdcheckoutsa.z6.web.core.windows.net"
    dev_react_app_products_asset           = "https://dev.selfcare.pagopa.it/assets/products.json"
    dev_react_app_login_alert_banner       = "https://dev.selfcare.pagopa.it/assets/login-alert-message.json"
    dev_react_app_plans_prices             = "https://dev.selfcare.pagopa.it/assets/app-io-premium-plans.json"
    dev_react_app_country_data             = "https://dev.selfcare.pagopa.it/country-data.json"
    dev_react_app_aggregates_example_csv   = "https://dev.selfcare.pagopa.it/resources/enti_aggregatori_template_esempio.csv"
    dev_react_app_login_spid_enabled       = "false"
    dev_react_app_url_privacy_disclaimer   = "https://dev.selfcare.pagopa.it/auth/informativa-privacy"
    dev_react_app_url_terms_and_conditions = "https://dev.selfcare.pagopa.it/auth/termini-di-servizio"
    dev_react_app_url_fe_login             = "https://dev.selfcare.pagopa.it/auth"
    dev_react_app_url_fe_onboarding        = "https://dev.selfcare.pagopa.it/onboarding"
    dev_react_app_url_fe_onboarding-pnpg   = "https://dev.selfcare.pagopa.it/onboarding-pnpg"
    dev_react_app_url_fe_dashboard         = "https://dev.selfcare.pagopa.it/dashboard"
    dev_react_app_url_fe_dashboard_admin   = "https://dev.selfcare.pagopa.it/microcomponents/dashboard/admin"
    dev_react_app_url_fe_dashboard_users   = "https://dev.selfcare.pagopa.it/microcomponents/dashboard/users"
    dev_react_app_enable_user_v2           = "true"
    dev_react_app_url_fe_dashboard_groups  = "https://dev.selfcare.pagopa.it/microcomponents/dashboard/groups"
    dev_react_app_url_fe_assistance        = "https://dev.selfcare.pagopa.it/assistenza"
    dev_react_app_url_fe_landing           = "https://dev.selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    dev_react_app_url_fe_token_exchange    = "https://dev.selfcare.pagopa.it/token-exchange"

    dev_react_app_url_api_login                = "https://api.dev.selfcare.pagopa.it/spid-login/v1"
    dev_react_app_url_api_party_registry_proxy = "https://api.dev.selfcare.pagopa.it/party-registry-proxy/v1"
    dev_react_app_url_api_dashboard            = "https://api.dev.selfcare.pagopa.it/dashboard"
    dev_react_app_url_api_onboarding           = "https://api.dev.selfcare.pagopa.it/onboarding/v1"
    dev_react_app_url_api_onboarding_v2        = "https://api.dev.selfcare.pagopa.it/onboarding"

    uat_react_app_url_cdn                      = "https://uat.selfcare.pagopa.it"
    uat_react_app_url_storage                  = "https://selcucheckoutsa.z6.web.core.windows.net"
    uat_react_app_products_asset               = "https://uat.selfcare.pagopa.it/assets/products.json"
    uat_react_app_login_alert_banner           = "https://uat.selfcare.pagopa.it/assets/login-alert-message.json"
    uat_react_app_plans_prices                 = "https://uat.selfcare.pagopa.it/assets/app-io-premium-plans.json"
    uat_react_app_country_data                 = "https://uat.selfcare.pagopa.it/country-data.json"
    uat_react_app_aggregates_example_csv       = "https://uat.selfcare.pagopa.it/resources/enti_aggregatori_template_esempio.csv"
    uat_react_app_login_spid_enabled           = "false"
    uat_react_app_url_privacy_disclaimer       = "https://uat.selfcare.pagopa.it/auth/informativa-privacy"
    uat_react_app_url_terms_and_conditions     = "https://uat.selfcare.pagopa.it/auth/termini-di-servizio"
    uat_react_app_url_fe_login                 = "https://uat.selfcare.pagopa.it/auth"
    uat_react_app_url_fe_onboarding            = "https://uat.selfcare.pagopa.it/onboarding"
    uat_react_app_url_fe_dashboard             = "https://uat.selfcare.pagopa.it/dashboard"
    uat_react_app_url_fe_onboarding-pnpg       = "https://uat.selfcare.pagopa.it/onboarding-pnpg"
    uat_react_app_url_fe_dashboard_admin       = "https://uat.selfcare.pagopa.it/microcomponents/dashboard/admin"
    uat_react_app_url_fe_dashboard_users       = "https://uat.selfcare.pagopa.it/microcomponents/dashboard/users"
    uat_react_app_enable_user_v2               = "true"
    uat_react_app_url_fe_dashboard_groups      = "https://uat.selfcare.pagopa.it/microcomponents/dashboard/groups"
    uat_react_app_url_fe_assistance            = "https://uat.selfcare.pagopa.it/assistenza"
    uat_react_app_url_fe_landing               = "https://uat.selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    uat_react_app_url_fe_token_exchange        = "https://uat.selfcare.pagopa.it/token-exchange"
    uat_react_app_url_api_login                = "https://api.uat.selfcare.pagopa.it/spid-login/v1"
    uat_react_app_url_api_party_registry_proxy = "https://api.uat.selfcare.pagopa.it/party-registry-proxy/v1"
    uat_react_app_url_api_dashboard            = "https://api.uat.selfcare.pagopa.it/dashboard"
    uat_react_app_url_api_onboarding           = "https://api.uat.selfcare.pagopa.it/onboarding/v1"
    uat_react_app_url_api_onboarding_v2        = "https://api.uat.selfcare.pagopa.it/onboarding"

    prod_react_app_url_cdn                      = "https://selfcare.pagopa.it"
    prod_react_app_url_storage                  = "https://selcpcheckoutsa.z6.web.core.windows.net"
    prod_react_app_products_asset               = "https://selfcare.pagopa.it/assets/products.json"
    prod_react_app_login_alert_banner           = "https://selfcare.pagopa.it/assets/login-alert-message.json"
    prod_react_app_plans_prices                 = "https://selfcare.pagopa.it/assets/app-io-premium-plans.json"
    prod_react_app_country_data                 = "https://selfcare.pagopa.it/country-data.json"
    prod_react_app_aggregates_example_csv       = "https://selfcare.pagopa.it/resources/enti_aggregatori_template_esempio.csv"
    prod_react_app_login_spid_enabled           = "false"
    prod_react_app_url_privacy_disclaimer       = "https://selfcare.pagopa.it/auth/informativa-privacy"
    prod_react_app_url_terms_and_conditions     = "https://selfcare.pagopa.it/auth/termini-di-servizio"
    prod_react_app_url_fe_login                 = "https://selfcare.pagopa.it/auth"
    prod_react_app_url_fe_onboarding            = "https://selfcare.pagopa.it/onboarding"
    prod_react_app_url_fe_dashboard             = "https://selfcare.pagopa.it/dashboard"
    prod_react_app_url_fe_onboarding-pnpg       = "https://selfcare.pagopa.it/onboarding-pnpg"
    prod_react_app_url_fe_dashboard_admin       = "https://selfcare.pagopa.it/microcomponents/dashboard/admin"
    prod_react_app_url_fe_dashboard_users       = "https://selfcare.pagopa.it/microcomponents/dashboard/users"
    prod_react_app_enable_user_v2               = "true"
    prod_react_app_url_fe_dashboard_groups      = "https://selfcare.pagopa.it/microcomponents/dashboard/groups"
    prod_react_app_url_fe_assistance            = "https://selfcare.pagopa.it/assistenza"
    prod_react_app_url_fe_landing               = "https://selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    prod_react_app_url_fe_token_exchange        = "https://selfcare.pagopa.it/token-exchange"
    prod_react_app_url_api_login                = "https://api.selfcare.pagopa.it/spid-login/v1"
    prod_react_app_url_api_party_registry_proxy = "https://api.selfcare.pagopa.it/party-registry-proxy/v1"
    prod_react_app_url_api_dashboard            = "https://api.selfcare.pagopa.it/dashboard"
    prod_react_app_url_api_onboarding           = "https://api.selfcare.pagopa.it/onboarding/v1"
    prod_react_app_url_api_onboarding_v2        = "https://api.selfcare.pagopa.it/onboarding"
  }

  selc-be-common-variables_deploy = {
    dev_container_registry_service_conn  = azuredevops_serviceendpoint_azurecr.selfcare-azurecr-dev.service_endpoint_name
    dev_kubernetes_service_conn          = azuredevops_serviceendpoint_kubernetes.selfcare-aks-dev.service_endpoint_name
    dev_container_registry_name          = "selcdacr.azurecr.io"
    dev_agent_pool                       = "selfcare-dev-linux"
    uat_container_registry_service_conn  = azuredevops_serviceendpoint_azurecr.selfcare-azurecr-uat.service_endpoint_name
    uat_kubernetes_service_conn          = azuredevops_serviceendpoint_kubernetes.selfcare-aks-uat.service_endpoint_name
    uat_container_registry_name          = "selcuacr.azurecr.io"
    uat_agent_pool                       = "selfcare-uat-linux"
    prod_container_registry_service_conn = azuredevops_serviceendpoint_azurecr.selfcare-azurecr-prod.service_endpoint_name
    prod_kubernetes_service_conn         = azuredevops_serviceendpoint_kubernetes.selfcare-aks-prod.service_endpoint_name
    prod_container_registry_name         = "selcpacr.azurecr.io"
    prod_agent_pool                      = "selfcare-prod-linux"
  }
}
