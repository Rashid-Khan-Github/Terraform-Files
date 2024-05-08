# values written in variables file are default values.
# we can always override the default values.

variable "ami-id" {
  type    = string                  # this is the data type
  default = "ami-0f3c7d07486cad139" # this is the default value
}

variable "instance_type" {
  default = "t2.micro"
}

variable "sg_name" {
  default = "Allow_ALLSG"
}

variable "sg_cidr" {
  default = ["0.0.0.0/0"]
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

variable "isPROD" {
  default = true
}

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