variable "ami-id" {
  type    = string                  # this is the data type
  default = "ami-0f3c7d07486cad139" # this is the default value
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_names" {
  type    = list(any)
  default = ["MongoDB", "Catalogue", "Redis", "User", "Cart", "MySql", "Shipping", "Rabbitmq", "Payment", "Web"]
}

variable "zone_id" {

  default = "Z0513646AB3WBDGO9A9V"

}

variable "domain" {

  default = "bsebregistration.com"

}
