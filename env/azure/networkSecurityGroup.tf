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
    }
  ]
  
  tags = {
    environment = "dev"
  }

  depends_on = [azurerm_resource_group.DemoRG]
}