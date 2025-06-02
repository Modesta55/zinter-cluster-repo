variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westeurope"  # since you said environment is prod & location is westeurope
}

variable "aks_node_vm_size" {
  description = "VM size for AKS node pools"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
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
  description = "Minimum nodes in autoscaler node pool"
  type        = number
}

variable "aks_max_node_count" {
  description = "Maximum nodes in autoscaler node pool"
  type        = number
}
