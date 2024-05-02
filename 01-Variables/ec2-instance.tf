resource "aws_instance" "My_Tera_EC2" {
  ami             = var.ami-id
  instance_type   = var.instance-type
  security_groups = [aws_security_group.Allow_All.name]
  tags            = var.instance_tags

}
