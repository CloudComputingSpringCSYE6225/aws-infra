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
  description = "Public CIDR block"
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

variable "ami_id" {
  type    = string
  default = "ami-0c463a0c925814cfc"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"

}

variable "instance_volume_size" {
  type    = number
  default = 50
}

variable "instance_volume_type" {
  type    = string
  default = "gp2"
}

variable "app_port" {
  type    = number
  default = 8080
}

variable "db_engine" {
  type    = string
  default = "postgres"
}

variable "db_instance" {
  type    = string
  default = "db.t3.micro"
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "db_instance_identifier" {
  type    = string
  default = "csye6225"
}

variable "db_username" {
  type    = string
  default = "csye6225"
}

variable "db_password" {
  type = string
}

variable "db_name" {
  type    = string
  default = "csye6225"
}

variable "db_port" {
  type = number
  default = 5432
}
locals {
  timestamp           = timestamp()
  timestamp_sanitized = replace("${local.timestamp}", "/[- TZ:]/", "")
}