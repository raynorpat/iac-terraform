terraform {
  required_version = ">=1.1.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.90"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.subscription
  tenant_id       = var.tenant
}
provider "github" {
  token = var.github_token
  owner = var.github_owner
}

locals  {
  api_token_var = "AZURE_STATIC_WEB_APPS_API_TOKEN"
}

resource "azurerm_resource_group" "raynorpat-web-rg" {
  name     = "raynorpat-web-rg"
  location = var.azure_region
}

resource "azurerm_static_site" "raynorpat-web-swa" {
  name                = "raynorpat-web-swa"
  resource_group_name = azurerm_resource_group.raynorpat-web-rg.name
  location            = azurerm_resource_group.raynorpat-web-rg.location
  sku_size            = "Free"
  sku_tier            = "Free"  
}

output "static_web_app_default_hostname" {
  description = "The default hostname associated with the Static Web App."
  value       = azurerm_static_site.raynorpat-web-swa.default_host_name
}

#
# may need to import if web exists already with terraform.exe -chdir=raynorpat-web import github_repository.web_repo web
#
resource "github_repository" "web_repo" {
  name      = "web"
  auto_init = true
}

resource "github_actions_secret" "azure_swa_api_key" {
  repository       = github_repository.web_repo.name
  secret_name      = local.api_token_var
  plaintext_value  = azurerm_static_site.raynorpat-web-swa.api_key
}

resource "github_repository_file" "azure_swa_yml" {
  repository          = github_repository.web_repo.name
  branch              = "master" # not main
  file                = ".github/workflows/azure-static-web-app.yml"
  content             = templatefile("./azure-static-web-app.tpl",
    {
      app_location = "/"
      api_location = "api"
      output_location = ""
      api_token_var = local.api_token_var
    }
  )
  commit_message      = "Add workflow (by Terraform)"
  commit_author       = "raynorpat"
  commit_email        = "raynorpat@raynorpat.com"
  overwrite_on_create = true
}