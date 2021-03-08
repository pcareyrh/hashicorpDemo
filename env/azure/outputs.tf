
output "azurerm_Resource_Group" {
  value = azurerm_resource_group.DemoRG.name
}
/*
output "linux_vm_public_name" {
  value = module.linuxservers.public_ip_dns_name
}

output "linux_vm_public_ip" {
  value = module.linuxservers.public_ip_address
}
*/

output "public_ip" {
  value = azurerm_linux_virtual_machine.DemoVM.public_ip_address
}