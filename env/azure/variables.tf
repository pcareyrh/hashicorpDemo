variable "location" {
  type = string
  default = "australiasoutheast"
}

variable "instance_count" {
  type = number
}

variable "prefix" {
  type    = string
  default = "Demo"
}

variable "tags" {
  type = map

  default = {
    Env = "dev"
  }
}
