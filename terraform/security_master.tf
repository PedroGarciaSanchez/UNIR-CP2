# Security group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

# Manages a network security group that contains a list of network security rules. Network security groups enable inbound or
# outbound traffic to be enabled or denied.
resource "azurerm_network_security_group" "mySecGroup" {
    name                = "sshtraffic_master"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

   #For http
   # security_rule {
   #     name                       = "K8s"
   #     priority                   = 1002
   #     direction                  = "Inbound"
   #     access                     = "Allow"
   #     protocol                   = "Tcp"
   #     source_port_range          = "*"
   #     destination_port_range     = "31542"
   #     source_address_prefix      = "*"
   #     destination_address_prefix = "*"
   # }

   #For Jenkins
    security_rule {
        name                       = "K8s"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "32145"
        source_address_prefix      = "*"
    #    destination_address_prefix = "*"
    destination_address_prefix = "10.0.1.11/32"
    }

    tags = {
        environment = "CP2"
    }
}

# Vinculamos el security group al interface de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

# Manages the association between a Network Interface and a Network Security Group.
resource "azurerm_network_interface_security_group_association" "mySecGroupAssociationMaster" {
    network_interface_id      = azurerm_network_interface.myNicMaster.id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id

}
