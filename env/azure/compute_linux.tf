resource "azurerm_linux_virtual_machine" "DemoVM" {
  name                = var.instance_name
  resource_group_name = azurerm_resource_group.DemoRG.name
  location            = azurerm_resource_group.DemoRG.location
  size                = "Standard_D2s_v3"
  admin_username      = var.admin_username

  admin_ssh_key {
    username = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

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

  part {
    content_type = "text/cloud-config"
    content      = file("./scripts/cloud-init.txt")
  }
}
