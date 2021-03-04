module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.DemoRG.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]

  #nsg_ids = {
  #  subnet1 = azurerm_network_security_group.ssh.id
  #}

  tags = {
    env = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.DemoRG]
}
/*
resource "azurerm_network_security_group" "ssh" {
  name                = "ssh"
  resource_group_name = azurerm_resource_group.DemoRG.name
  location            = azurerm_resource_group.DemoRG.location

  security_rule {
    name                       = "Allow SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}
*/
# Create subnet
#resource "azurerm_subnet" "subnet" {
#  name                 = "myTFSubnet"
#  resource_group_name  = azurerm_resource_group.rg.name
#  virtual_network_name = azurerm_virtual_network.vnet.name
#  address_prefixes     = ["10.0.1.0/24"]
#}

# Create a virtual network
#resource "azurerm_virtual_network" "vnet" {
#    name                = "myTFVnet"
#    address_space       = ["10.0.0.0/16"]
#    location            = var.location
#    resource_group_name = azurerm_resource_group.rg.name
#}