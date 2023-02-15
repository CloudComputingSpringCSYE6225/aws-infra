variable "region" {
  type        = string
  description = "AWS region to use"
  default     = "us-east-1"

}

variable "profile" {
  type        = string
  description = "Profile to use for deployment"
  default     = "dev"

}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"

}

variable "public_cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "0.0.0.0/0"
}

variable "public_subnet_count" {
  type    = number
  default = 3
}

variable "private_subnet_count" {
  type    = number
  default = 3
}

#variable "public_subnets" {
#  type = list
#  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#}
#
#variable "private_subnets" {
#  type = list
#  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
#}