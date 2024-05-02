variable "ami-id" {

  type    = string                  # this is the data type
  default = "ami-0f3c7d07486cad139" # this is the default value

}

variable "instance-type" {

  default = "t2.micro" # this is the default value

}

variable "security_group_name" {

  default = "allow-all-sg"

}

variable "sg_cidr" {
  type    = list(any)
  default = ["0.0.0.0/0"]

}

variable "instance_tags" {
  type = map(any)
  default = {
    Name        = "MongoDB"
    Environment = "DEV"
    Terraform   = true
    Project     = "Roboshop"
    Component   = "MongoDB"
  }
}