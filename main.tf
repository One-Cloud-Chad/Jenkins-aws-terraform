provider "aws" {
  region     = var.region
  profile    = "Development"
  access_key = ""
  secret_key = ""
}
terraform {
  required_version = ">= 0.12.0"
}
