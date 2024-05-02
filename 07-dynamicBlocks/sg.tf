resource "aws_instance" "Roboshop" {
  for_each      = var.instances
  ami           = var.ami-id
  instance_type = each.value
  tags = {
    Name = each.key
  }
}

resource "aws_security_group" "Robo_SG" {
  name        = "Roboshop_SG"
  description = "Allowing HTTP, HTTPS and SSH Ports from anyone"
  #vpc_id =  If not given it will take default vpc

  #   dynamic "ingress" {
  #     for_each = var.ingress_list
  #     content {
  #       description = ingress.value.description
  #       from_port   = ingress.value.from_port
  #       to_port     = ingress.value.to_port
  #       protocol    = ingress.value.protocol
  #       cidr_blocks = ingress.value.cidr_blocks
  #     }
  #   }

  dynamic "ingress" {
    for_each = var.ingress_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}