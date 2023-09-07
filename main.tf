# Configure the Azure provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tg" {
  name     = "testGroup"
  location = "eastus"
}

resource "azurerm_service_plan" "test_plan" {
  name                = "test_service_plan"
  location            = azurerm_resource_group.tg.location
  resource_group_name = azurerm_resource_group.tg.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "test_app" {
  name                = "ignaoya-terraform-test-app"
  resource_group_name = azurerm_resource_group.tg.name
  location            = azurerm_service_plan.test_plan.location
  service_plan_id     = azurerm_service_plan.test_plan.id

  site_config {
    always_on = false
  }
}