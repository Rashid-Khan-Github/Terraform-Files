resource "aws_security_group" "Allow_All" {

  name        = var.security_group_name
  description = "Allowing all ports"

  tags = {
    Name = "Allow-All-SG"
  }

  ingress {
    description = "Allowing all inbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = var.sg_cidr

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = var.sg_cidr
  }


}