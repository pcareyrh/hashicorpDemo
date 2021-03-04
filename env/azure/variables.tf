variable "location" {
  type = string
  default = "australiasoutheast"
}

variable "servercount" {
  type = number
}
variable "admin_username" {
    type = string
    description = "Administrator user name for virtual machine"
    default = "patrick"
}

variable "admin_password" {
    type = string
    description = "Password must meet Azure complexity requirements"
    default = "Patrick01"
}

variable "prefix" {
  type    = string
  default = "my"
}

variable "tags" {
  type = map

  default = {
    Env = "dev"
    Dept        = "Engineering"
  }
}

variable "sku" {
  default = {
    westus2 = "16.04-LTS"
    australiasoutheast  = "18.04-LTS"
  }
}
