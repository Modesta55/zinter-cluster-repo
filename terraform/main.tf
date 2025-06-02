resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-vnet"
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "aks_system" {
  name                 = "${var.prefix}-subnet-system"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_system_address_prefix]
}

resource "azurerm_subnet" "aks_workload" {
  name                 = "${var.prefix}-subnet-workload"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_workload_address_prefix]
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.prefix}-dns"

  default_node_pool {
    name           = "default"
    vm_size        = var.aks_node_vm_size
    node_count     = 1
    vnet_subnet_id = azurerm_subnet.aks_system.id
    type           = "VirtualMachineScaleSets"
    node_labels = {
      role = "system"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  role_based_access_control_enabled = true

  azure_active_directory_role_based_access_control {
    admin_group_object_ids = [var.aad_admin_group_object_id]
    tenant_id              = var.tenant_id
  }

  local_account_disabled     = true
  oidc_issuer_enabled        = true
  workload_identity_enabled  = true

  tags = {
    Environment = "Production"
    Owner       = "Modesta"
    CostCenter  = "AKS"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "autoscaler" {
  name                  = "autoscaler"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.aks_node_vm_size
  vnet_subnet_id        = azurerm_subnet.aks_workload.id
  auto_scaling_enabled  = true
  min_count             = var.aks_min_node_count
  max_count             = var.aks_max_node_count
  mode                  = "User"

  node_labels = {
    role = "internal-app"
  }

  node_taints = [
    "workload=internal:NoSchedule"
  ]

  tags = {
    Environment = "Production"
    Owner       = "Modesta"
    CostCenter  = "AKS"
    NodeType    = "autoscaler"
  }
}
