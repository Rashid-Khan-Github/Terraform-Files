resource "aws_instance" "Condtional_EC2" {
  ami           = var.ami-id
  instance_type = var.instance_name == "MongoDB" ? "t2.micro" : "t3.micro"

}