variable "cidr_block" {
  #   default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}

variable "common_tags" {
  default = {} # these braces means tags are optional
  type    = map
}

variable "vpc_tags" {
  default = {} # these braces means tags are optional
  type    = map
}

variable "igw_tags" {
  default = {} # these braces means tags are optional
  type    = map
}

variable "public_subnet_cidr" {
   type = list
}

variable "private_subnet_cidr" {
   type = list
}

variable "azones" {
   type = list
}

variable "public_subnet_names" {
   type = list
}

variable "private_subnet_names" {
  type = list
}

variable "database_subnet_cidr" {
  type = list
}

variable "database_subnet_names" {
  type = list
}

variable "public_route_table_tags" {
  default = {}
}

variable "private_route_table_tags" {
  default = {}
}

variable "database_route_table_tags" {
  default = {}
}