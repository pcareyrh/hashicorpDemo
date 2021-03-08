/*module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.DemoRG.name
  vm_hostname         = var.vm_hostname
  admin_username      = var.admin_username
  enable_ssh_key      = true
  vm_os_simple        = "CentOS"
  storage_account_type = "Standard_LRS"
  nb_instances        = var.instance_count
  remote_port         = "22"
  //public_ip_dns       = var.vm_hostname // change to a unique name per datacenter region
  vnet_subnet_id      = module.vnet.vnet_subnets[0]
  custom_data         = base64encode("hostname")
  #.vnet_subnets[0]
/*
  vm_hostname                   = "mylinuxvm"
  nb_public_ip                  = 0
  remote_port                   = "22"
  nb_instances                  = 2
  vm_os_publisher               = "Canonical"
  vm_os_offer                   = "UbuntuServer"
  vm_os_sku                     = "18.04-LTS"
  vnet_subnet_id                = module.vnet_subnet_id
  boot_diagnostics              = true
  delete_os_disk_on_termination = true
  nb_data_disk                  = 2
  data_disk_size_gb             = 64
  data_sa_type                  = "Premium_LRS"
  enable_ssh_key                = true
  ssh_key_values                = ["ssh-rsa AAAAB3NzaC1yc2EAAAAD..."]  
  vm_size                       = "Standard_D4s_v3"
//* /

  depends_on = [azurerm_resource_group.DemoRG]
}
*/
resource "azurerm_linux_virtual_machine" "DemoVM" {
  name                = "DemoVM"
  resource_group_name = azurerm_resource_group.DemoRG.name
  location            = azurerm_resource_group.DemoRG.location
  size                = "Standard_D2s_v3"
  admin_username      = "centos"

  admin_ssh_key {
    username = "centos"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  # This is where we pass our cloud-init.
  custom_data = data.template_cloudinit_config.config.rendered

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.demo-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_8"
    version   = "latest"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    content_type = "text/cloud-config"
    content      = file("cloud-init.txt")
  }
}
