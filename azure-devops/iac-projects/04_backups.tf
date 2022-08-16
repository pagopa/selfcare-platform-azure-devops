variable "apim_backup" {
  default = {
    repository = {
      organization    = "pagopa"
      name            = "cstar-infrastructure"
      branch_name     = "refs/heads/main"
      pipelines_path  = ".devops"
      yml_prefix_name = "backup-apim"
    }
  }
}

module "apim_backup" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.6.2"

  project_id                   = data.azuredevops_project.project.id
  repository                   = var.apim_backup.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.io-azure-devops-github-pr.id
  path                         = "backups"
  pipeline_name_prefix         = "backup-apim"

  ci_trigger_use_yaml           = true
  pull_request_trigger_use_yaml = true

  variables = {
    apim_name                 = "cstar-p-apim"
    apim_rg                   = "cstar-p-api-rg"
    storage_account_name      = "cstarpbackupstorage"
    backup_name               = "apim-backup"
    storage_account_container = "apim"
    storage_account_rg        = "cstar-p-storage-rg"
  }

  variables_secret = {}

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_azurerm.PROD-CSTAR.id,
  ]

  schedules = {
    days_to_build              = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    schedule_only_with_changes = false
    start_hours                = 7
    start_minutes              = 20
    time_zone                  = "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"
    branch_filter = {
      include = ["main"]
      exclude = []
    }
  }
}
