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

resource "aws_instance" "WebServer" {
  ami           = "ami-0bac9d0b7acaea5d4" #CentOS Stream 8 / ap-southeast-2
  instance_type = "t2.micro"
  key_name = "xpskeypair"
  security_groups = [ "default", "allow_web", "allow_ssh" ]

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y epel-release ansible", 
      "sudo cd /tmp && curl -O https://raw.githubusercontent.com/pcareyrh/hashicorpDemo/main/apache_install.yml",
      "sudo ansible-playbook /tmp/apache_install.yml" ]
  }
  tags = {
    Name = "WebSever"
  }
}

#resource "aws_instance" "VaultServer" {
#  ami           = "ami-0bac9d0b7acaea5d4" #CentOS Stream 8 / ap-southeast-2
#  instance_type = "t2.micro"
#  key_name = "xpskeypair"
#  security_groups = [ "default", "allow_vault", "allow_ssh" ]

#  tags = {
#    Name = "vaultServer"
#  }
#}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web inbound"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow web inbound"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow secure web inbound"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow ssh inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_vault" {
  name        = "allow_vault"
  description = "Allow vault group"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow vault inbound"
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow vault api inbound"
    from_port   = 8201
    to_port     = 8201
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_vault"
  }
}

