data "azurerm_kubernetes_cluster" "aks" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_kubernetes_cluster.aks.resource_group_name

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}


provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
  }
}
