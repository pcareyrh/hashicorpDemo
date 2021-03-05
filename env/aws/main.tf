terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.30.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-southeast-2"
}

/*
resource "aws_instance" "WebServer" {
  ami           = "ami-0bac9d0b7acaea5d4" #CentOS Stream 8 / ap-southeast-2
  instance_type = "t2.micro"
  key_name = "xpskeypair"
  security_groups = [ "default", "allow_web", "allow_ssh" ]

  tags = {
    Name = "WebSever"
  }
  
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
}
*/
#resource "aws_instance" "VaultServer" {
#  ami           = "ami-0bac9d0b7acaea5d4" #CentOS Stream 8 / ap-southeast-2
#  instance_type = "t2.micro"
#  key_name = "xpskeypair"
#  security_groups = [ "default", "allow_vault", "allow_ssh" ]

#  tags = {
#    Name = "vaultServer"
#  }
#}


