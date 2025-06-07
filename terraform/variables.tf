variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "prefix" {
  description = "Prefix for naming all resources (e.g. mariotech)"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westeurope"
}

variable "aks_node_vm_size" {
  description = "VM size for AKS node pools"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network (e.g. 10.0.0.0/8)"
  type        = string
}

variable "subnet_system_address_prefix" {
  description = "Address prefix for the AKS system node pool subnet"
  type        = string
}

variable "subnet_workload_address_prefix" {
  description = "Address prefix for the AKS workload (autoscaler) node pool subnet"
  type        = string
}

variable "aks_min_node_count" {
  description = "Minimum number of nodes in autoscaler pool"
  type        = number
  default     = 1
}

variable "aks_max_node_count" {
  description = "Maximum number of nodes in autoscaler pool"
  type        = number
  default     = 3
}

variable "resource_group_name" {
  description = "The name of the resource group (used only if reusing an existing one)"
  type        = string
  default     = ""
}

variable "aad_admin_group_object_id" {
  description = "Azure AD group object ID for AKS Admin RBAC"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}



# ✅ Optional: Customize static public IP name
variable "nginx_static_ip_name" {
  description = "Name for the static public IP used by NGINX ingress"
  type        = string
  default     = "nginx-ingress-ip"
}
