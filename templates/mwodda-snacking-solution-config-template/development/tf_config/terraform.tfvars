environment_abbreviation   = "DEV"
solution_abbreviation      = "{solution_product_short_name}"
resource_abbreviation      = "{solution_resource_name}"
azure_subscription_id      = "c6bfc6b3-5e5e-45f8-b6b7-2f8f1c8a1a0e"
azure_tenant_id            = "2fc13e34-f03f-498b-982a-7cb446e25bc6"
azure_core_subscription_id = "8252c545-440b-4a7f-b925-26aa409f42af"
environment_config = {
  solution_settings = {
    environment_abbreviation            = "DEV"
    solution_develop_entra_group_access = "WRITER"
    solution_service_principal_name     = "Stage - DNA-DEV-MW-DEMAND-{solution_resource_name}-EUS2"
    cicd_service_principal_name         = "Stage - DNA-DEV-MW-DEMAND-{solution_resource_name}-CICD-EUS2"
  }


  databricks = {

    secret_to_spark_env_mappings = {
      aoh-spclientid        = "aoh-spclientid",
      aoh-spsecret          = "aoh-spsecret",
      cicd-sp-client-id     = "cicd-sp-client-id",
      cicd-sp-client-secret = "cicd-sp-client-secret",
      sp-client-id          = "sp-client-id",
      sp-client-secret      = "sp-client-secret",
      shared-PAT            = "shared-PAT",
    }

    interactive_cluster_custom_tags = {
      "x_Environment" : "DEV"
      "x_Product" : "{solution_resource_name}"
      "x_Cluster_Type" : "All-Purpose"
      "Team" : "{solution_resource_name}-TEAM"
    }

    cluster_pool_custom_tags = {
      "x_Environment" : "DEV"
      "x_Product" : "{solution_resource_name}"
      "x_Cluster_Type" : "Job"
    }

    databricks_group_roles = {
      "developers" = {
        cluster_create                = false
        cluster_pool_create           = false
        cluster_permission_level      = "CAN_MANAGE"
        folder_permission_level       = "CAN_EDIT"
        repos_folder_permission_level = "CAN_MANAGE"
        scope_permision_level         = "READ"
      }
      "admins" = {
        cluster_create                = false
        cluster_pool_create           = false
        cluster_permission_level      = "CAN_MANAGE"
        folder_permission_level       = "CAN_MANAGE"
        repos_folder_permission_level = "CAN_MANAGE"
        scope_permision_level         = "READ"
      }
      "service" = {
        cluster_create                = false
        cluster_pool_create           = false
        cluster_permission_level      = "CAN_MANAGE"
        folder_permission_level       = "CAN_RUN"
        repos_folder_permission_level = "CAN_RUN"
        scope_permision_level         = "READ"
      }
    }
    interactive_clusters = {
      "solution_cluster" = {
        spark_version      = "13.3.x-scala2.12"
        shared_policy_name = "DNA Product Compute Policy"
        node_type_id       = "Standard_D4ads_v5"
        spark_conf = {
          "fs.azure.account.auth.type.demandstageeus2devsa.dfs.core.windows.net" : "OAuth"
          "fs.azure.account.oauth2.client.secret.demandstageeus2devsa.dfs.core.windows.net" : "{{secrets/{solution_product_short_name}-SECRETSCOPE/sp-client-secret}}"
          "fs.azure.account.oauth2.client.id.demandstageeus2devsa.dfs.core.windows.net" : "{{secrets/{solution_product_short_name}-SECRETSCOPE/sp-client-id}}"
          "fs.azure.account.oauth.provider.type.demandstageeus2devsa.dfs.core.windows.net" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
          "fs.azure.account.oauth2.client.endpoint.demandstageeus2devsa.dfs.core.windows.net" : "https://login.microsoftonline.com/2fc13e34-f03f-498b-982a-7cb446e25bc6/oauth2/token"
          "fs.azure.account.auth.type.demandlakeeus2devsa.dfs.core.windows.net" : "OAuth"
          "fs.azure.account.oauth2.client.secret.demandlakeeus2devsa.dfs.core.windows.net" : "{{secrets/{solution_product_short_name}-SECRETSCOPE/sp-client-secret}}"
          "fs.azure.account.oauth.provider.type.demandlakeeus2devsa.dfs.core.windows.net" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
          "fs.azure.account.oauth2.client.id.demandlakeeus2devsa.dfs.core.windows.net" : "{{secrets/{solution_product_short_name}-SECRETSCOPE/sp-client-id}}"
          "fs.azure.account.oauth2.client.endpoint.demandlakeeus2devsa.dfs.core.windows.net" : "https://login.microsoftonline.com/2fc13e34-f03f-498b-982a-7cb446e25bc6/oauth2/token"
          "fs.azure.account.auth.type.demandvaulteus2devsa.dfs.core.windows.net" : "OAuth"
          "fs.azure.account.oauth2.client.secret.demandvaulteus2devsa.dfs.core.windows.net" : "{secrets/{solution_product_short_name}-SECRETSCOPE/sp-client-secret}}"
          "fs.azure.account.oauth2.client.id.demandvaulteus2devsa.dfs.core.windows.net" : "{{secrets/{solution_product_short_name}-SECRETSCOPE/sp-client-id}}"
          "fs.azure.account.oauth.provider.type.demandvaulteus2devsa.dfs.core.windows.net" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
          "fs.azure.account.oauth2.client.endpoint.demandvaulteus2devsa.dfs.core.windows.net" : "https://login.microsoftonline.com/2fc13e34-f03f-498b-982a-7cb446e25bc6/oauth2/token"
          "fs.azure.account.oauth2.client.endpoint.marsanalyticsprodadls.dfs.core.windows.net" : "https://login.microsoftonline.com/2fc13e34-f03f-498b-982a-7cb446e25bc6/oauth2/token"
          "fs.azure.account.oauth2.client.secret.marsanalyticsprodadls.dfs.core.windows.net" : "{{secrets/{solution_product_short_name}-SECRETSCOPE/aoh-spsecret}}"
          "fs.azure.account.auth.type.marsanalyticsprodadls.dfs.core.windows.net" : "OAuth"
          "fs.azure.account.oauth.provider.type.marsanalyticsprodadls.dfs.core.windows.net" : "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider"
          "fs.azure.account.oauth2.client.id.marsanalyticsprodadls.dfs.core.windows.net" : "{{secrets/{solution_product_short_name}-SECRETSCOPE/aoh-spclientid}}"
          "spark.databricks.service.server.enabled" = "true"
        }
      }
    }
    cluster_pools = {
      "solution_cluster_pool" = {
        node_type_id                               = "Standard_D4ads_v5"
        spark_version                              = "13.3.x-scala2.12"
        max_capacity                               = 100
        disk_spec_disk_type_azure_disk_volume_type = "PREMIUM_LRS"
      }
    }
    # Canot be change refer document      
    custom_policies = {
      "solution_cluster_pool_policy" = {
        policy_definition = {
          "spark_version" : {
            "type" : "fixed",
            "value" : "13.3.x-scala2.12"
          },
          "autoscale.min_workers" : {
            "type" : "fixed",
            "value" : 1
          },
          "autoscale.max_workers" : {
            "type" : "range",
            "maxValue" : 10,
            "defaultValue" : 4
          },
          "cluster_type" : {
            "type" : "fixed",
            "value" : "job"
          },
          "runtime_engine" : {
            "type" : "fixed",
            "value" : "STANDARD"
          },
          "data_security_mode" : {
            "hidden" : true,
            "type" : "fixed",
            "value" : "NONE"
          }
        }

      }
    }
  }
}