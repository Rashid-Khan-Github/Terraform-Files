variable "health_check" {
  default = {
    enabled             = true
    healthy_threshold   = 2 # consider as healthty if 2 health checks are success
    interval            = 120
    matcher             = "200-299"
    path                = "/health"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3 # consider unhealthy if 3 health check fails
  }
}

variable "project_name" {

}

variable "common_tags" {

}

variable "env" {

}


#============================================================================

variable "target_group_port" {

}

variable "target_group_protocol" {

}

variable "vpc_id" {

}

variable "image_id" {

}

variable "instance_type" {
  default = "t2.micro"
}

variable "security_group_id" {

}

variable "user_data" {

}

variable "launch_template_tags" {
  default = []
}

#============================================================================

variable "max_size" {
  default = 3
}

variable "min_size" {
  default = 1
}

variable "desired_capacity" {
  default = 2
}

variable "health_check_grace_period" {
  default = 300
}

variable "health_check_type" {
  default = "ELB"
}

variable "vpc_zone_identifier" {
  type = list(any)
}

variable "tag" {
  default = []
}

#============================================================================

variable "autoscaling_cpu_target" {
  default = 75.0
}

#============================================================================

variable "alb_listener_arn" {

}

variable "rule_priority" {

}

variable "host_header" {

}
