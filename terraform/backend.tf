terraform {
  cloud {
    organization = "tf-demo-gcp-modesta"
    workspaces {
      name = "zinter-app"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.31.0"
    }
  }
}
