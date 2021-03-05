module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.DemoRG.name
  vm_os_simple        = "CentOS"
  storage_account_type = "Standard_LRS"
  nb_instances        = var.instance_count
  remote_port         = "22"
#  public_ip_dns       = ["linsimplevmips"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.vnet.vnet_subnets[0]
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
*/

  provisioner "remote-exec" {
    inline = [
      "curl -O https://raw.githubusercontent.com/pcareyrh/hashicorpDemo/main/apache_install.yml",
      "sudo yum install -y epel-release && sudo yum -y install ansible",
      "sudo ansible-playbook /home/centos/apache_install.yml" 
    ]
    
    connection {
      type     = "ssh"
      host     = self.public_ip
      user     = "centos"
      private_key = file("~/.ssh/id_rsa")
      timeout  = "3m"
    }
  }
    
  depends_on = [azurerm_resource_group.DemoRG]
}