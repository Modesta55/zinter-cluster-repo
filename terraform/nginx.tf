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
