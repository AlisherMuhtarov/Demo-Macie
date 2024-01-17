terraform {
  required_version = "~> 1.6.6" # Terraform Version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.32.1" # AWS Provider
    }
  }
}