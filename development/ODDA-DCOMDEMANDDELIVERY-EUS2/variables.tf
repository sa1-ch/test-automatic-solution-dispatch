variable "azure_active_directory_group_owner" {
  description = "E-mail of a user who is to be set as the owner of AAD groups created together with resource group"
  type        = list(string)
  default     = ["venkata.vamsi.ammireddy@effem.com", "shahul.hameed@effem.com", "venkatasri.chodapaneedi@effem.com", "satya.gokada@effem.com"]
}

variable "environment_abbreviation" {
  description = "Abbreviation of environment, e.g. DEV or PROD"
  type        = string
  validation {
    condition     = contains(["DEV", "PROD"], var.environment_abbreviation)
    error_message = "Unsupported environment abbreviation. Supported values include: DEV, PROD."
  }
}

variable "environment_config" {
  type        = any
  description = "Configuration values specific to the environment"
}

variable "solution_abbreviation" {
  type        = string
  description = "Solution abbreviation"
}

variable "resource_abbreviation" {
  type        = string
  description = "resource abbreviation"
}

variable "azure_subscription_id" {
  type        = string
  description = "Env azure_subscription_id"
}

variable "azure_tenant_id" {
  type        = string
  description = "Env azure_tenat_id"
}

variable "azure_core_subscription_id" {
  type        = string
  description = "azure_core_subscription_id"
}