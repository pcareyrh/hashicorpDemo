module "network-security-group" {
  source                = "Azure/network-security-group/azurerm"
  resource_group_name   = azurerm_resource_group.DemoRG.name
  security_group_name   = "NetSecurityGroup"
  source_address_prefix = ["*"]
  predefined_rules = [
    {
      name     = "SSH"
      priority = "100"
    },
    {
      name              = "HTTP"
      priority          = "101"
      #source_port_range = "1024-1026"
    }
  ]

  #custom_rules = [
   # {
    #  name                   = "myssh"
     # priority               = 201
      #direction              = "Inbound"
      #access                 = "Allow"
     # protocol               = "tcp"
    #  source_port_range      = "*"
   #   destination_port_range = "22"
  #    source_address_prefix  = "10.151.0.0/24"
 #     description            = "description-myssh"
#    }
#  ]

  tags = {
    environment = "dev"
  }

  depends_on = [azurerm_resource_group.DemoRG]
}