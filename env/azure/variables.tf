variable "location" {
  type = string
  default = "australiasoutheast"
}

variable "resource_group_name" {
  type = string
  default = "DemoRG"
}
variable "instance_count" {
  type = number
}

variable "instance_name" {
  type = string
  default = "DemoVM"
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed."
  type        = string
  default     = "centos"
}

variable "vm_hostname" {
  description = "local name of the Virtual Machine."
  type        = string
  default     = "DemoVM"
}