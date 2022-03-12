# Security group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

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

 #   security_rule {
 #       name                       = "K8s"
 #       priority                   = 1002
 #       direction                  = "Inbound"
 #       access                     = "Allow"
 #       protocol                   = "Tcp"
 #       source_port_range          = "*"
 #       destination_port_range     = "32104"
 #       source_address_prefix      = "*"
 #       destination_address_prefix = "*"
 #   }

    tags = {
        environment = "CP2"
    }
}

# Vinculamos el security group al interface de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "mySecGroupAssociationMaster" {
    network_interface_id      = azurerm_network_interface.myNicMaster.id
    network_security_group_id = azurerm_network_security_group.mySecGroup.id

}
#TODO:
#resource "azurerm_network_interface_security_rule" "K8s" {
#        name                       = "k8s"
#        priority                   = 1002
#        direction                  = "Inbound"
#        access                     = "Allow"
#        protocol                   = "Tcp"
#        source_port_range          = "*"
#        destination_port_range     = "el que me salga"
#        source_address_prefix      = "*"
#        destination_address_prefix = "*"
#    }