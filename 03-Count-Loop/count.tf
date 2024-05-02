resource "aws_instance" "Robo_Servers" {
  ami           = var.ami-id
  instance_type = (var.instance_names[count.index] == "MongoDB" || var.instance_names[count.index] == "MySql") ? "t3.micro" : "t2.micro"
  count         = 10
  tags = {
    Name = var.instance_names[count.index]
  }
}


resource "aws_route53_record" "record" {
  count   = 10
  zone_id = var.zone_id
  name    = "${var.instance_names[count.index]}.${var.domain}"
  type    = "A"
  ttl     = 1
  records = [aws_instance.Robo_Servers[count.index].private_ip]
}

resource "aws_key_pair" "MyKey" {
  key_name   = "MyAWSKey"
  public_key = file("${path.module}/MyKey.pub")
}