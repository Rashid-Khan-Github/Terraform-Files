variable "project_name" {
  default = "roboshop"
}

variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Component   = "web"
    Environment = "DEV"
    Terraform   = true
  }
}

variable "env" {
  default = "dev"
}

#======================================================================================

variable "health_check" {
  default = {
    enabled             = true
    healthy_threshold   = 2 # consider as healthty if 2 health checks are success
    interval            = 120
    matcher             = "200-299"
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3 # consider unhealthy if 3 health check fails
  }
}

variable "target_group_port" {
  default = 80
}

variable "target_group_protocol" {
  default = "HTTP"
}

variable "launch_template_tags" {
  default = [
    {
      resource_type = "instance"
      tags = {
        Name = "Web"
      }
    },
    {
      resource_type = "volume"
      tags = {
        Name = "Web"
      }
    }
  ]
}

#======================================================================================

variable "autoscaling_tags" {
  default = [
    {
      key                 = "Name"
      value               = "web"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "Roboshop"
      propagate_at_launch = true
    }
  ]
}
