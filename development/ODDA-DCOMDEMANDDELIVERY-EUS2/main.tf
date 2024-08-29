module "ODDA-DCOMDEMANDDELIVERY-PROJECT" {
  source = "git@github.snacking-templates:Mars-DNA/Snacking-Templates.git//snacking-solution-infra-template?ref=snacking-solution-infra-template-v-{module_version}"
  solution_settings = {
    solution_prefix          = "ODDA"
    solution_name            = local.solution_name
    environment_abbreviation = var.environment_config.solution_settings.environment_abbreviation
    tags = {
      "Environment" : "Dev",
      "Application" : "MW-ODDA",
      "Application Architect" : "rich.nixon@effem.com",
      "Application Category" : "",
      "Brand" : "Mars Wrigley",
      "Business Owner" : "",
      "Business Unit" : "Mars Wrigley",
      "Region" : "",
      "Charge Reference" : "",
      "Charge Type" : "",
      "CMDB" : "DNA-${var.environment_abbreviation}-MW-DEMAND-DCOMODD-EUS2",
      "Created" : "",
      "Created By" : "Terraform",
      "Data Classification" : "",
      "Data Sensitivity" : "",
      "Expiry" : "9999-12-31",
      "Function" : "Demand",
      "Infrastructure Tier" : "",
      "Parent" : "",
      "Product" : "",
      "Product Owner" : "",
      "Program" : "",
      "Project" : "",
      "Segment" : "Mars Wrigley",
      "Updated" : "",
      "Support Model" : "ODDA-INFRA-POD@effem.com",
      "Banner" : "",
      "Division" : "",
    }
    spoke_abbr               = local.spoke_abbr
    prov_group_name          = "DNA-${var.environment_config.solution_settings.environment_abbreviation}-MW-DEMAND-PROVISIONER"
    entra_group_owner_emails = var.azure_active_directory_group_owner
    solution_admins_emails = [
      "hardik.talati@effem.com",
      "shravan.shravankumar@effem.com",
      "amitoz.s.sidhu@effem.com"
    ]
    solution_service_principal_name     = var.environment_config.solution_settings.solution_service_principal_name
    solution_develop_entra_group_access = var.environment_config.solution_settings.solution_develop_entra_group_access
    main_admin_entra_group              = "DNA-${var.environment_config.solution_settings.environment_abbreviation}-MW-ODDA-ADMIN"
    location                            = "eastus2"
    tenant_id                           = var.azure_tenant_id
    cicd_service_principal_name         = var.environment_config.solution_settings.cicd_service_principal_name
  }
  shared_resources = {
    resource_groups = {
      storage = {
        rg_name                 = "DEMAND-STORAGE-EUS2-${var.environment_config.solution_settings.environment_abbreviation}-RG"
        reader_entra_group_name = "DNA-DEMANDSTORAGE-${var.environment_config.solution_settings.environment_abbreviation}-READER"
      }
      shared = {
        rg_name                 = "ODDA-SHARED-EUS2-${var.environment_config.solution_settings.environment_abbreviation}-RG"
        reader_entra_group_name = "DNA-ODDASHARED-${var.environment_config.solution_settings.environment_abbreviation}-READER"
        app_service_plans_tf_keys_to_resource_names = {
          "shared_weblnx_app_service_plan" : "oddasharedweblnxeus2${local.environment_abbreviation_lower}asp",
          "shared_logic_app_service_plan" : "oddasharedlaeus2${local.environment_abbreviation_lower}asp"
        }
        acr_tf_keys_to_resource_names = {
          "shared_acr" = "oddasharedeus2${local.environment_abbreviation_lower}conreg"
        }
        log_analytics_workspace_name = "oddasharedeus2${local.environment_abbreviation_lower}log"
      }
    }
  }
  key_vaults = {
    "solution_key_vault" = {
      service_solution_abbr = local.resource_abbr
      akv_subnet            = local.subnet_names.key_vault
    }
  }
  databricks = {
    key_vault_tf_instance_key               = "solution_key_vault"
    secretscope_name                        = "${local.solution_name}-SECRETSCOPE"
    workspace_folder_name                   = local.solution_name
    repos_folder_name                       = local.solution_name
    databricks_secret_to_spark_env_mappings = var.environment_config.databricks.secret_to_spark_env_mappings
    databricks_group_roles                  = var.environment_config.databricks.databricks_group_roles
    shared_policy_names_to_read             = ["DNA Product Compute Policy"]
    interactive_clusters = {
      "solution_cluster" = {
        spark_version                   = var.environment_config.databricks.interactive_clusters.solution_cluster.spark_version
        shared_policy_name              = var.environment_config.databricks.interactive_clusters.solution_cluster.shared_policy_name
        node_type_id                    = var.environment_config.databricks.interactive_clusters.solution_cluster.node_type_id
        cluster_name                    = "${local.solution_name}-CLUSTER"
        interactive_cluster_custom_tags = var.environment_config.databricks.interactive_cluster_custom_tags
        spark_conf                      = var.environment_config.databricks.interactive_clusters.solution_cluster.spark_conf
      }
    }
    cluster_pools = {
      "solution_cluster_pool" = {
        node_type_id                               = var.environment_config.databricks.cluster_pools.solution_cluster_pool.node_type_id
        spark_version                              = var.environment_config.databricks.cluster_pools.solution_cluster_pool.spark_version
        pool_name                                  = "${local.solution_name}-POOL"
        max_capacity                               = var.environment_config.databricks.cluster_pools.solution_cluster_pool.max_capacity
        disk_spec_disk_type_azure_disk_volume_type = var.environment_config.databricks.cluster_pools.solution_cluster_pool.disk_spec_disk_type_azure_disk_volume_type
        cluster_pools_custom_tags                  = var.environment_config.databricks.cluster_pool_custom_tags
      }
    }
    custom_policies = {
      "solution_cluster_pool_policy" = {
        policy_name                   = "DNA ${local.resource_abbr} Pool Compute Policy"
        cluster_pool_tf_instance_keys = ["solution_cluster_pool"]
        policy_definition             = var.environment_config.databricks.custom_policies.solution_cluster_pool_policy.policy_definition
      }
    }
  }
  datalake = {
    platform_name_prefix = ""
    project_directory_targets = {
      "LAKE"  = ["RAW", "OUTPUT"]
      "VAULT" = ["RAW", "OUTPUT"]
      "STAGE" = ["PROCESS"]
    }
    directory_name = local.solution_name
  }
  app_services = {
    DCOMODD_webapp = {
      service_solution_abbr            = local.resource_abbr
      runtime_version                  = "3.11"
      docker_image_name                = var.environment_config.app_services.solution_webapp.docker_image_name
      cmdb_tag                         = var.environment_config.app_services.solution_webapp.cmdb_tag
      acr_tf_instance_key              = "shared_acr"
      app_service_plan_tf_instance_key = "shared_weblnx_app_service_plan"
      http2_enabled                    = true
      app_type                         = "LinuxAppService"
    }
  }
  storage_accounts = {
    "solution_sa" = {
      service_solution_abbr        = local.storage_abbr
      replication_type             = var.environment_config.solution_settings["environment_abbreviation"] == "DEV" ? "LRS" : "GRS"
      private_endpoint_subnet_name = local.subnet_names.storage_account
      resource_type_suffix         = "sa"
    }
  }
  logic_apps = {
    "DCOMODD" = {
      service_solution_abbr            = local.resource_abbr
      storage_account_tf_instance_key  = "solution_sa"
      app_service_plan_tf_instance_key = "shared_logic_app_service_plan"
    }
  }
}
