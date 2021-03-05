module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "test-ec2-instance"
  instance_count = var.instance_count

  ami                    = "ami-0bac9d0b7acaea5d4"
  instance_type          = "t2.micro"
  key_name               = "xpskeypair"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id, aws_security_group.allow_web.id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data              = file("./scripts/cloud-init.yml")

  tags = {
    Demo   = "true"
    Env = "dev"
  }

}
