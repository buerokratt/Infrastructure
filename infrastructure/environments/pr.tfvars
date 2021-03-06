environment_name    = "pr"
environment_postfix = "" # This value will be set via the GH workflow
primary_region      = "westeurope"
secondary_region    = "northeurope"

# KeyVault configuration
keyvault_enabled_for_deployment          = "true"
keyvault_enabled_for_disk_encryption     = "true"
keyvault_enabled_for_template_deployment = "true"
keyvault_purge_protection_enabled        = "false"

cosmos_throughput = 400
