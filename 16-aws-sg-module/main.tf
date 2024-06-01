resource "aws_security_group" "main_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id = var.vpc_id

    dynamic ingress {
      for_each = var.sg_ingress_rules
      iterator = maps
      
      content {
        description = maps.value.description
        from_port   = maps.value.from_port
        to_port     = maps.value.to_port
        protocol    = maps.value.protocol
        cidr_blocks = maps.value.cidr_blocks
      }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(
        {
            Name = "${var.project_name}-${var.sg_name}"
        },
        var.common_tags
    )

}