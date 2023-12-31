variable "tenant" {
  description = "Tenant ID"
  type        = string
  default     = "daf54655-653a-4ba2-b612-4d9c45fb4a8d" # FE tenant
}

variable "subscription" {
  description = "Subscription ID"
  type        = string
  default     = "d9acd8e6-0e74-4e77-8c9f-0ca8c4d037f1" # Azure Plan Subscription
}

variable "azure_region" {
  description = "Azure region"
  type        = string
  default     = "eastus2"
}

# make sure GitHub access token has workflow scope, otherwise you'll get 404 errors
variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  default     = ""  
}

variable "github_owner" {
  description = "GitHub User account"
  type        = string
  default     = ""  
}