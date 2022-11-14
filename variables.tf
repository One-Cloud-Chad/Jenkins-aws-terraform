variable "region" {
  default = "us-east-1"
}

variable "environment" {
  default = "Development"
}

variable "vpc_cidr" {
  description = "VPC cidr block"
}

variable "public_subnet_1_cidr" {
  description = "Public Subnet 1 cidr block"
}

variable "public_subnet_2_cidr" {
  description = "Public Subnet 2 cidr block"
}

variable "public_subnet_3_cidr" {
  description = "Public Subnet 3 cidr block"
}

variable "private_subnet_1_cidr" {
  description = "Private Subnet 1 cidr block"
}

variable "private_subnet_2_cidr" {
  description = "Private Subnet 2 cidr block"
}

variable "private_subnet_3_cidr" {
  description = "Private Subnet 3 cidr block"
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "t2.medium"
}

variable "ssh_key" {
  default     = "~/.ssh/id_rsa_jenkins.pub"
}

variable "install_jenkins" {
  default     = "~/github/jenkins-aws-terraform/scripts/install_jenkins.sh"
}