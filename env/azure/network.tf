
resource "azurerm_virtual_network" "demo-vnet" {
  name                = "demo-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.DemoRG.location
  resource_group_name = azurerm_resource_group.DemoRG.name
}

resource "azurerm_subnet" "demo-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.DemoRG.name
  virtual_network_name = azurerm_virtual_network.demo-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "demo-nic" {
  name                = "demo-nic1"
  location            = azurerm_resource_group.DemoRG.location
  resource_group_name = azurerm_resource_group.DemoRG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.demo-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id

  }
}

resource "azurerm_public_ip" "pip" {
  name                = "demo-pip"
  resource_group_name = azurerm_resource_group.DemoRG.name
  location            = azurerm_resource_group.DemoRG.location
  allocation_method   = "Dynamic"
}
