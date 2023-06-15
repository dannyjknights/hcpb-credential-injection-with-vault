variable "boundary_addr" {
  type = string
}

variable "auth_method_id" {
  type = string
}

variable "password_auth_method_login_name" {
  type = string
}

variable "password_auth_method_password" {
  type = string
}

variable "aws_access" {
  type = string
}

variable "aws_secret" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "private_vpc_cidr" {
  type        = string
  description = "The Private CIDR range to assign to the VPC"
}

variable "aws_vpc_cidr" {
  type        = string
  description = "The AWS Region CIDR range to assign to the VPC"
}

variable "private_subnet_cidr" {
  type        = string
  description = "The Private CIDR range to assign to the Private subnet"
}

variable "aws_subnet_cidr" {
  type        = string
  description = "The AWS Region CIDR range to assign to the Private subnet"
}

variable "availability_zone" {
  type        = string
  description = "Region within AWS to deploy the resources"
  default     = "eu-west-2b"
}

variable "vault_addr" {
  type = string
}

variable "vault_token" {
  type = string
}

variable "boundary_vault_token" {
  type = string
}

variable "instances" {
  default = [
    "boundary-1-dev",
    # "boundary-2-dev",
    # "boundary-3-production",
    # "boundary-4-production"
  ]
}

variable "vm_tags" {
  default = [
    { "Name" : "boundary-1-dev", "service-type" : "database", "application" : "dev" },
    # { "Name" : "boundary-2-dev", "service-type" : "database", "application" : "dev" },
    # { "Name" : "boundary-3-production", "service-type" : "database", "application" : "production" },
    # { "Name" : "boundary-4-production", "service-type" : "database", "application" : "production" }
  ]
}