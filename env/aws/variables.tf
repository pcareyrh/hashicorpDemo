variable "vpc_name" {
  description = "Name of VPC to deploy"
  type = string
  default = "DemoVPC"
}
variable "instance_count" {
  description = "Number of EC2 instances to deploy"
  type = number
}

variable "instance_name" {
  description = "instance name/s"
  type = string
  default = "DemoVM"
}