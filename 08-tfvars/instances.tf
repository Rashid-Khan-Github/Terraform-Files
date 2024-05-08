resource "aws_instance" "Robo_EC2" {
  for_each      = var.instances
  ami           = var.ami-id
  instance_type = each.value
  tags = {
    default = each.key
  }
}

resource "aws_route53_record" "record_ec2" {
  for_each = aws_instance.Robo_EC2
  zone_id  = var.zone_id
  name     = "${each.key}.${var.domain}"
  type     = "A"
  ttl      = 1
  records  = [each.key == "Web" ? each.value.public_ip : each.value.private_ip]

}

resource "aws_security_group" "Allow_All_SG" {
  name        = var.sg_name
  description = "Allowing all ports"

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
    protocol    = "tcp"
    cidr_blocks = var.sg_cidr
  }

}
