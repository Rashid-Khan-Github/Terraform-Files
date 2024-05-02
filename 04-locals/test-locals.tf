
resource "aws_key_pair" "MyKey" {
  key_name   = "MyAWSKey"
  public_key = local.key_public
}

resource "aws_instance" "EC2WithKey" {
    ami = local.ami_id
    instance_type = local.instance_type
    key_name = aws_key_pair.MyKey.key_name
}