output "aks_cluster_name" {
  value       = azurerm_kubernetes_cluster.aks.name
  description = "The name of the AKS cluster"
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].raw_kube_config
  sensitive   = true
  description = "Raw kubeconfig file content for accessing the AKS cluster"
}
