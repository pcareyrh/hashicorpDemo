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