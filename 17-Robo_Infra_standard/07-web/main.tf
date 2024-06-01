module "web_module" {
  source       = "../robo-comp-module"
  project_name = var.project_name
  env          = var.env
  common_tags  = var.common_tags
  health_check = var.health_check

  # target group
  target_group_port     = var.target_group_port
  target_group_protocol = var.target_group_protocol
  vpc_id                = data.aws_ssm_parameter.vpc_id.value

  # launch template
  image_id             = data.aws_ami.devops_ami.id
  security_group_id    = data.aws_ssm_parameter.web_sg_id.value
  user_data            = filebase64("${path.module}/web.sh")
  launch_template_tags = var.launch_template_tags

  #autoscaling group
  vpc_zone_identifier = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  tag = var.autoscaling_tags

  #autoscaling policy -> I'm good with optional parameters

  #Web_listner_rule
  alb_listener_arn = data.aws_ssm_parameter.web_alb_listener_arn.value
  rule_priority = 10
  host_header = "bsebregistration.com"

  

}
