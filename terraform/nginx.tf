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
  service:
    type: LoadBalancer
EOF
  ]
}