# Creación de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

# Manages a virtual network including any configured subnets. Each subnet can optionally be 
# configured with a security group to be associated with the subnet.
resource "azurerm_virtual_network" "myNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

# Creación de subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
# Manages a subnet. Subnets represent network segments within the IP space 
# defined by the virtual network.

resource "azurerm_subnet" "mySubnet" {
    name                   = "terraformsubnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.1.0/24"]

}

# Create NIC
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

#Manages a Network Interface.
resource "azurerm_network_interface" "myNicMaster" {
  name                = "vmnicMaster"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfigurationMaster"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.10"
    public_ip_address_id           = azurerm_public_ip.myPublicIpMaster.id
  }

    tags = {
        environment = "CP2"
    }

}

# IP pública
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

#Public IP Addresses aren't allocated until they're assigned to a resource (such as a Virtual Machine
# or a Load Balancer) by design within Azure

resource "azurerm_public_ip" "myPublicIpMaster" {
  name                = "vmipMaster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}