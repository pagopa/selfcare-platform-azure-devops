locals {

  idpay-fe-common-variables_deploy = {

    blob_container_name = "$web"

    git_mail          = "TODO" //module.secrets.values["io-azure-devops-github-EMAIL"].value
    git_username      = "TODO" //module.secrets.values["io-azure-devops-github-USERNAME"].value
    github_connection = "TODO" //azuredevops_serviceendpoint_github.io-azure-devops-github-rw.service_endpoint_name

    dev_azure_subscription = local.service_endpoint_azure_dev_id #azuredevops_serviceendpoint_azurerm.DEV-SERVICE-CONN.service_endpoint_name
    dev_cdn_endpoint       = "cstar-d-weu-idpay-idpaycdn-cdn-endpoint"
    dev_cdn_profile        = "cstar-d-weu-idpay-idpaycdn-cdn-profile"
    dev_resource_group     = "cstar-d-idpay-cdn-rg"
    dev_storage_account    = "cstardweuidpayidpaycdnsa"
    dev_analytics_enabled  = "true"
    dev_analytics_mocked   = "true" //Put to false when mixpanel available
    dev_mixpanel_token     = "TODO" //"6e1290bdda5885981a2f443f37444f0f"
    dev_onetrust_domain_id = "TODO" //"a8f58d7a-7f6a-4fe6-ac02-f95bac3876d4-test"

    uat_azure_subscription = "TODO" #azuredevops_serviceendpoint_azurerm.UAT-SERVICE-CONN.service_endpoint_name
    uat_cdn_endpoint       = "cstar-u-weu-idpay-idpaycdn-cdn-endpoint"
    uat_cdn_profile        = "cstar-u-weu-idpay-idpaycdn-cdn-profile"
    uat_resource_group     = "cstar-u-idpay-cdn-rg"
    uat_storage_account    = "cstaruweuidpayidpaycdnsa"
    uat_analytics_enabled  = "true"
    uat_analytics_mocked   = "true" //Put to false when mixpanel available
    uat_mixpanel_token     = "TODO" //"1d1b09b008638080ab34fe9b75db84fd"
    uat_onetrust_domain_id = "TODO" //"15a1f042-9257-450f-b9e8-38d019191729"

    prod_azure_subscription = "TODO" #azuredevops_serviceendpoint_azurerm.PROD-SERVICE-CONN.service_endpoint_name
    prod_cdn_endpoint       = "cstar-P-weu-idpay-idpaycdn-cdn-endpoint"
    prod_cdn_profile        = "cstar-p-weu-idpay-idpaycdn-cdn-profile"
    prod_resource_group     = "cstar-p-idpay-cdn-rg"
    prod_storage_account    = "cstarpweuidpayidpaycdnsa"
    prod_analytics_enabled  = "true"
    prod_analytics_mocked   = "true" //Put to false when mixpanel available
    prod_mixpanel_token     = "TODO" //"1d1b09b008638080ab34fe9b75db84fd"
    prod_onetrust_domain_id = "TODO" //"084d5de2-d423-458a-9b28-0f8db3e55e71"

    react_app_assistance_email = "selfcare@assistenza.pagopa.it"

    dev_react_app_url_cdn            = "https://welfare.dev.cstar.pagopa.it/"
    dev_react_app_url_storage        = "https://cstardweuidpayidpaycdnsa.z6.web.core.windows.net/"
    dev_react_app_url_fe_login       = "https://dev.selfcare.pagopa.it/auth"
    dev_react_app_url_fe_assistance  = "https://dev.selfcare.pagopa.it/assistenza"
    dev_react_app_url_fe_landing     = "https://dev.selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    dev_react_app_url_api_initiative = "https://api-io.dev.cstar.pagopa.it/idpay/initiative"

    uat_react_app_url_cdn           = "https://welfare.uat.cstar.pagopa.it/"
    uat_react_app_url_storage       = "https://cstaruweuidpayidpaycdnsa.z6.web.core.windows.net/"
    uat_react_app_url_fe_login      = "https://uat.selfcare.pagopa.it/auth"
    uat_react_app_url_fe_assistance = "https://uat.selfcare.pagopa.it/assistenza"
    uat_react_app_url_fe_landing    = "https://uat.selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    uat_react_app_url_api_portal    = "TODO"

    prod_react_app_url_cdn           = "https://welfare.cstar.pagopa.it/"
    prod_react_app_url_storage       = "https://cstarpweuidpayidpaycdnsa.z6.web.core.windows.net/"
    prod_react_app_url_fe_login      = "https://selfcare.pagopa.it/auth"
    prod_react_app_url_fe_assistance = "https://selfcare.pagopa.it/assistenza"
    prod_react_app_url_fe_landing    = "https://selfcare.pagopa.it/auth/logout" // TODO when the landing will exists, replace this with the correct URL
    prod_react_app_url_api_portal    = "TODO"

  }

}
