#=====================================================
# VPC variables

variable "cidr_block" {
  default = "10.0.0.0/16"
}


variable "project_name" {
  default = "roboshop"
}

variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Component   = "dev"
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


#=====================================================
# Security group variables

variable "sg_ingress_rules" {
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allowing all traffic from internet"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "sg_tags" {
  default = {
    Name = "Robo_Allow_All_SG"
  }
}

#=====================================================
# Ec2 Instances variables

variable "instances" {
  type = map(any)
  default = {
    MongoDB   = "t2.micro"
    Catalogue = "t2.micro"
    Redis     = "t2.micro"
    User      = "t2.micro"
    Cart      = "t2.micro"
    MySql     = "t2.micro"
    Shipping  = "t2.micro"
    Rabbitmq  = "t2.micro"
    Payment   = "t2.micro"
    Web       = "t2.micro"
  }
}

#=====================================================
# Route53 Variables

variable "zone_name" {
  default = "bsebregistration.com"
}
