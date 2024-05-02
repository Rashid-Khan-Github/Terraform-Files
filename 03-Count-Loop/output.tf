output "private_ips" {
  value = aws_instance.Robo_Servers[*].private_ip
}