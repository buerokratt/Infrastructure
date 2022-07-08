#
# Deploy Nginx Ingress Controller to the AKS cluster
#

resource "azurerm_public_ip" "nginx_ingress" {
  name                = "${var.name}-ingress-pip"
  resource_group_name = local.nodes_resource_group
  location            = var.resource_group.location
  allocation_method   = "Static"
  sku                 = local.public_ip_sku
  domain_name_label   = local.public_ip_domain_name_label

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

# TODO: Need to rename this to 'applications' namespace
# resource "kubernetes_namespace" "nginx_ingress" {
#   metadata {
#     name = "nginx-ingress"
#   }
#   depends_on = [
#     azurerm_kubernetes_cluster.aks
#   ]
# }

resource "helm_release" "nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "applications" # kubernetes_namespace.nginx_ingress.metadata.0.name
  create_namespace = true

  set {
    name  = "controller.replicaCount"
    value = 2
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = local.health_endpoint
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-dns-label-name"
    value = azurerm_public_ip.nginx_ingress.domain_name_label
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.nginx_ingress.ip_address
  }
}
