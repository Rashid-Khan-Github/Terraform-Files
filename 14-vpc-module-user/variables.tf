
variable "cidr_block" {
  default = "10.0.0.0/16"
}


variable "project_name" {
  default = "Roboshop"
}

variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Environment = "DEV"
    Terraform   = true
  }
}

variable "vpc_tags" {
  default = {
    Name = "Roboshop_VPC"
  }
}

variable "public_subnet_cidr" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidr" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidr" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}