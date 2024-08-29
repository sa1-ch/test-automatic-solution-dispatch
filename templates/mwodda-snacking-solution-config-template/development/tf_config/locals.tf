locals {
  subnet_names = {
    storage_account            = "sapesnet-003",
    app_service                = "appsnet-001"
    logic_app_integration      = "appsnet-001"
    key_vault_private_endpoint = "akvpesnet-001",
    adf                        = "adfpesnet-001"
  }
  solution_prefix = "ODDA"
  solution_name   = var.solution_abbreviation
  resource_abbr   = var.resource_abbreviation
  storage_abbr    = "${local.solution_prefix}${local.resource_abbr}"
  resource_group_names = {
    shared = "ODDA-SHARED-${local.location_abbr}-${var.environment_abbreviation}-RG"
  }
  location_abbr                  = "EUS2"
  spoke_abbr                     = "ODDACORE"
  vnet_name                      = "${local.spoke_abbr}${local.location_abbr}${local.environment_abbreviation_lower}vnet"
  vnet_rg                        = "${local.spoke_abbr}-NETWORK-${local.location_abbr}-${var.environment_abbreviation}-RG"
  environment_abbreviation_lower = lower(var.environment_config.solution_settings.environment_abbreviation)
}