resource "aws_lb_target_group" "catalogue_tg" {
  name     = "${var.project_name}-${var.common_tags.Component}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value

  health_check {
    enabled             = true
    healthy_threshold   = 2 # consider as healthy if 2 health checks are success
    interval            = 120
    matcher             = "200-299"
    path                = "/health"
    port                = 8080
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3 # consider unhealthy if 3 health check fails
  }
}

resource "aws_launch_template" "catalogue_lt" {
  name                                 = "${var.project_name}-${var.common_tags.Component}"
  image_id                             = data.aws_ami.devops_ami.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  vpc_security_group_ids               = [data.aws_ssm_parameter.catalogue_sg_id.value]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "catalogue"
    }
  }

  user_data = filebase64("${path.module}/catalogue.sh")
}

resource "aws_autoscaling_group" "catalogue_asg" {
  name                      = "${var.project_name}-${var.common_tags.Component}-asg"
  max_size                  = 4
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  target_group_arns         = [aws_lb_target_group.catalogue_tg.arn]

  launch_template {
    id      = aws_launch_template.catalogue_lt.id
    version = "$Latest"
  }
  vpc_zone_identifier = split(",", data.aws_ssm_parameter.private_subnet_ids.value)

  timeouts {
    delete = "15m"
  }
  tag {
    key                 = "Name"
    value               = "Catalogue"
    propagate_at_launch = false
  }
}

resource "aws_autoscaling_policy" "catalogue_asg_policy" {
  autoscaling_group_name = aws_autoscaling_group.catalogue_asg.name
  name                   = "cpu"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
}

resource "aws_lb_listener_rule" "catalogue_listner_rule" {
  listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.catalogue_tg.arn
  }

  condition {
    host_header {
      values = ["catalogue.app.bsebregistration.com"]
    }
  }
}
