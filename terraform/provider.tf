provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
}


provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks.kube_admin_config[0].host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config[0].cluster_ca_certificate)
  }
}

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"

  create_namespace = true

  values = [
    <<EOF
controller:
  replicaCount: 2
  nodeSelector:
    "kubernetes.io/os": linux
  service:
    type: LoadBalancer
  admissionWebhooks:
    enabled: true
EOF
  ]

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

