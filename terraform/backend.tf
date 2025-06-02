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
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.11.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 2.28.1"
    }
  }
}