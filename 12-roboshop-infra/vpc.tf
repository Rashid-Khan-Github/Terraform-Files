module "this_vpc" {

  source = "../11-aws-vpc-module"

  #VPC Creation
  cidr_block  = var.cidr_block
  common_tags = var.common_tags
  vpc_tags    = var.vpc_tags
  igw_tags    = var.internet_gateway_tags

  # Public Subnet Creation
  public_subnet_cidr  = var.public_subnet_cidr
  azones              = var.azones
  public_subnet_names = var.public_subnet_names

  # Private Subnet
  private_subnet_cidr = var.private_subnet_cidr
  private_subnet_names = var.private_subnet_names

  # Database Subnet
  database_subnet_cidr = var.database_subnet_cidr
  database_subnet_names = var.database_subnet_names

  # Route Parameters
  public_route_table_tags = var.public_route_table_tags
  private_route_table_tags = var.private_route_table_tags
  database_route_table_tags = var.database_route_table_tags
  

}






























# resource "aws_vpc" "robo-vpc" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name        = "Roboshop-VPC"
#     Environment = "DEV"
#     Terraform   = true
#   }
# }

# resource "aws_subnet" "robo-subnet-pub" {
#   vpc_id     = aws_vpc.robo-vpc.id
#   cidr_block = "10.0.0.0/24"

#   tags = {
#     Name = "Roboshop-Public-Subnet"
#   }
# }

# resource "aws_subnet" "robo-subnet-pri" {
#   vpc_id     = aws_vpc.robo-vpc.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "Robo-Private-Subnet"
#   }
# }


# resource "aws_internet_gateway" "robo-gateway" {
#   vpc_id = aws_vpc.robo-vpc.id

#   tags = {
#     Name = "Roboshop-Internet-Gateway"
#   }
# }

# resource "aws_route_table" "robo-public-route-table" {
#   vpc_id = aws_vpc.robo-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.robo-gateway.id
#   }

#   tags = {
#     Name = "Roboshop-public-route-table"
#   }
# }

# resource "aws_route_table" "robo-private-route-table" {
#   vpc_id = aws_vpc.robo-vpc.id

#   tags = {
#     Name = "Roboshop-private-route-table"
#   }
# }

# resource "aws_route_table_association" "public-route-subnet-assoc" {
#   subnet_id      = aws_subnet.robo-subnet-pub.id
#   route_table_id = aws_route_table.robo-public-route-table.id
# }

# resource "aws_route_table_association" "private-route-subnet-assoc" {
#   subnet_id      = aws_subnet.robo-subnet-pri.id
#   route_table_id = aws_route_table.robo-private-route-table.id
# }

# resource "aws_security_group" "allow-http-ssh-sg" {
#   name        = "Allow-SSH-HTTP"
#   description = "Only SSSH-HTTP"
#   vpc_id = aws_vpc.robo-vpc.id

#   ingress {
#     description = "Allowing HTTP inbound traffic"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#     ingress {
#     description = "Allowing SSH inbound traffic"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["152.59.86.89/32"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "Allow_Only_80_22"
#   }

# }

# resource "aws_instance" "Web" {

#   ami = "ami-0f3c7d07486cad139"
#   instance_type = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.allow-http-ssh-sg.id]
#   subnet_id = aws_subnet.robo-subnet-pub.id
#   associate_public_ip_address = true

#   tags = {
#     Name = "Web"
#   }


# }
