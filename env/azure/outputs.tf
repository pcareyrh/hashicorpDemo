
output "azurerm_Resource_Group" {
  value = azurerm_resource_group.DemoRG.name
}

output "public_ip" {
  value = azurerm_linux_virtual_machine.DemoVM.public_ip_address
}