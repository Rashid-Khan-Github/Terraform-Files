module "vpn_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "vpn_SG"
  sg_description = "Allowing all ports from my IP"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_vpc.default_vpc.id
  common_tags = merge(
    {
      Component = "VPN",
      Name      = "vpn_SG"
    }
  )
}

#=============================(DB_Security Groups)===========================

module "mongodb_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "mongodb_SG"
  sg_description = "Allowing traffic from Catalogue and VPN"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "MongoDB",
      Name      = "mongoDB_SG"
    }
  )
}

module "redis_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "redis_SG"
  sg_description = "Allowing traffic"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "redis",
      Name      = "redis_SG"
    }
  )
}

module "mysql_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "mysql_SG"
  sg_description = "Allowing traffic"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "mysql",
      Name      = "mysql_SG"
    }
  )
}

module "rabbitmq_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "rabbitmq_SG"
  sg_description = "Allowing traffic"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "rabbitmq",
      Name      = "rabbitmq_SG"
    }
  )
}

#=====================================================================



#=============================(AppTier_Security Groups)===============

module "catalogue_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "catalogue_SG"
  sg_description = "Allowing traffic from Web and VPN Component"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "Catalogue",
      Name      = "catalogue_SG"
    }
  )
}

module "user_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "user_SG"
  sg_description = "Allowing traffic"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "user",
      Name      = "user_SG"
    }
  )
}

module "cart_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "cart_SG"
  sg_description = "Allowing traffic"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "cart",
      Name      = "cart_SG"
    }
  )
}

module "shipping_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "shipping_SG"
  sg_description = "Allowing traffic"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "shipping",
      Name      = "shipping_SG"
    }
  )
}

module "payment_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "payment_SG"
  sg_description = "Allowing traffic"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "payment",
      Name      = "payment_SG"
    }
  )
}
#=====================================================================

#=============================(WebTier_Security Groups)===============
module "web_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "web_SG"
  sg_description = "Allowing traffic from web ALB and VPN Component"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "Web",
      Name      = "web_SG"
    }
  )
}

module "app_alb_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "app_alb_SG"
  sg_description = "Allowing traffic from web and VPN Component"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "App_ALB",
      Name      = "app_alb_SG"
    }
  )
}

module "web_alb_sg" {
  source         = "../../16-aws-sg-module"
  project_name   = var.project_name
  sg_name        = "web_alb_SG"
  sg_description = "Allowing traffic from Internet"
  #   sg_ingress_rules = var.sg_ingress_rules
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  common_tags = merge(
    var.common_tags,
    {
      Component = "Web_ALB",
      Name      = "web_alb_SG"
    }
  )
}


#================================================================================================

# This is allowing traffic from my ip to vpn
resource "aws_security_group_rule" "vpn_myip_rule" {
  type      = "ingress"
  from_port = 0
  to_port   = 65535
  protocol  = "tcp"
  # cidr_blocks       = ["${chomp(data.http.myip.response_body)}/32"]
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 for troubleshooting purpose
resource "aws_security_group_rule" "mongodb_vpn_rule" {
  type                     = "ingress"
  description              = "Allowing port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.mongodb_sg.security_group_id
}

# This is allowing connections from all catalogue instances on port 27017 to MongoDB
resource "aws_security_group_rule" "mongodb_catalogue_rule" {
  type                     = "ingress"
  description              = "Allowing port number 27017 from catalogue"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.catalogue_sg.security_group_id
  security_group_id        = module.mongodb_sg.security_group_id
}

# This is allowing connections from user on port 27017 to MongoDB
resource "aws_security_group_rule" "mongodb_user_rule" {
  type                     = "ingress"
  description              = "Allowing port number 27017 from catalogue"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  source_security_group_id = module.user_sg.security_group_id
  security_group_id        = module.mongodb_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 to Redis
resource "aws_security_group_rule" "redis_vpn_rule" {
  type                     = "ingress"
  description              = "Redis accepting traffic on port 22 from VPN"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.redis_sg.security_group_id
}

# This is allowing traffic from User on port no 6379 to Redis
resource "aws_security_group_rule" "redis_user_rule" {
  type                     = "ingress"
  description              = "Redis accepting traffic on port 6379 from User"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.user_sg.security_group_id
  security_group_id        = module.redis_sg.security_group_id
}

# This is allowing traffic from User on port no 6379 to Redis
resource "aws_security_group_rule" "redis_cart_rule" {
  type                     = "ingress"
  description              = "Redis accepting traffic on port 6379 from Cart"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = module.cart_sg.security_group_id
  security_group_id        = module.redis_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 to mysql
resource "aws_security_group_rule" "mysql_vpn_rule" {
  type                     = "ingress"
  description              = "mysql accepting traffic on port 22 from VPN"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.mysql_sg.security_group_id
}

# This is allowing traffic from shipping on port no 3306 to mysql
resource "aws_security_group_rule" "mysql_shipping_rule" {
  type                     = "ingress"
  description              = "mysql accepting traffic on port 3306 from shipping"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.shipping_sg.security_group_id
  security_group_id        = module.mysql_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 to rabbitmq
resource "aws_security_group_rule" "rabbitmq_vpn_rule" {
  type                     = "ingress"
  description              = "rabbitmq accepting traffic on port 22 from VPN"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.rabbitmq_sg.security_group_id
}

# This is allowing traffic from payment on port no 5672 to rabbitmq
resource "aws_security_group_rule" "rabbitmq_payment_rule" {
  type                     = "ingress"
  description              = "rabbitmq accepting traffic on port 5672 from payment"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  source_security_group_id = module.payment_sg.security_group_id
  security_group_id        = module.rabbitmq_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 for troubleshooting purpose
resource "aws_security_group_rule" "catalogue_vpn_rule" {
  type                     = "ingress"
  description              = "Allowing port number 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.catalogue_sg.security_group_id
}

# This is allowing traffic from app_alb on port no 8080 to catalogue
resource "aws_security_group_rule" "catalogue_app_alb_rule" {
  type                     = "ingress"
  description              = "Allowing port number 8080 from app_alb"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id        = module.catalogue_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 to User
resource "aws_security_group_rule" "user_vpn_rule" {
  type                     = "ingress"
  description              = "User accepting traffic on 22 from VPN"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.user_sg.security_group_id
}

# This is allowing traffic from App_ALB on port no 8080 to User
resource "aws_security_group_rule" "user_app_alb_rule" {
  type                     = "ingress"
  description              = "User accepting traffic on 8080 from App_ALB"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id        = module.user_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 to cart
resource "aws_security_group_rule" "cart_vpn_rule" {
  type                     = "ingress"
  description              = "Cart accepting traffic on 22 from VPN"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.cart_sg.security_group_id
}

# This is allowing traffic from app_alb on port no 8080 to cart
resource "aws_security_group_rule" "cart_app_alb_rule" {
  type                     = "ingress"
  description              = "Cart accepting traffic on 8080 from App_ALB"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id        = module.cart_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 to shipping
resource "aws_security_group_rule" "shipping_vpn_rule" {
  type                     = "ingress"
  description              = "Shipping accepting traffic on 22 from VPN"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.shipping_sg.security_group_id
}

# This is allowing traffic from app_alb on port no 8080 to shipping
resource "aws_security_group_rule" "shipping_app_alb_rule" {
  type                     = "ingress"
  description              = "shipping accepting traffic on 8080 from App_ALB"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id        = module.shipping_sg.security_group_id
}

# This is allowing traffic from VPN on port no 22 to payment
resource "aws_security_group_rule" "payment_vpn_rule" {
  type                     = "ingress"
  description              = "payment accepting traffic on 22 from VPN"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.payment_sg.security_group_id
}

# This is allowing traffic from app_alb on port no 8080 to payment
resource "aws_security_group_rule" "payment_app_alb_rule" {
  type                     = "ingress"
  description              = "payment accepting traffic on 8080 from App_ALB"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.security_group_id
  security_group_id        = module.payment_sg.security_group_id
}


# This is allowing traffic from VPN on port no 22 for troubleshooting purpose
resource "aws_security_group_rule" "app_alb_vpn_rule" {
  type                     = "ingress"
  description              = "app_alb accepting traffic on 80 from vpn"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.app_alb_sg.security_group_id
}

# This is allowing traffic from Web on port 80 to app_alb
resource "aws_security_group_rule" "app_alb_web_rule" {
  type                     = "ingress"
  description              = "app_alb accepting traffic on 80 from web"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.web_sg.security_group_id
  security_group_id        = module.app_alb_sg.security_group_id
}

# This is allowing traffic from catalogue on port 80 to app_alb
resource "aws_security_group_rule" "app_alb_catalogue_rule" {
  type                     = "ingress"
  description              = "app_alb accepting traffic on 80 from catalogue"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.catalogue_sg.security_group_id
  security_group_id        = module.app_alb_sg.security_group_id
}

# This is allowing traffic from user on port 80 to app_alb
resource "aws_security_group_rule" "app_alb_user_rule" {
  type                     = "ingress"
  description              = "app_alb accepting traffic on 80 from user"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.user_sg.security_group_id
  security_group_id        = module.app_alb_sg.security_group_id
}

# This is allowing traffic from cart on port 80 to app_alb
resource "aws_security_group_rule" "app_alb_cart_rule" {
  type                     = "ingress"
  description              = "app_alb accepting traffic on 80 from cart"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.cart_sg.security_group_id
  security_group_id        = module.app_alb_sg.security_group_id
}

# This is allowing traffic from shipping on port 80 to app_alb
resource "aws_security_group_rule" "app_alb_shipping_rule" {
  type                     = "ingress"
  description              = "app_alb accepting traffic on 80 from shipping"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.shipping_sg.security_group_id
  security_group_id        = module.app_alb_sg.security_group_id
}

# This is allowing traffic from payment on port 80 to app_alb
resource "aws_security_group_rule" "app_alb_payment_rule" {
  type                     = "ingress"
  description              = "app_alb accepting traffic on 80 from payment"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.payment_sg.security_group_id
  security_group_id        = module.app_alb_sg.security_group_id
}


# This is allowing traffic from vpn on port 22 to web
resource "aws_security_group_rule" "web_vpn_rule" {
  type                     = "ingress"
  description              = "web accepting traffic on 22 from vpn"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.security_group_id
  security_group_id        = module.web_sg.security_group_id
}


# This is allowing traffic from web_alb on port no 80 to web
resource "aws_security_group_rule" "web_web_alb_rule" {
  type                     = "ingress"
  description              = "web accepting traffic on 80 from web_alb"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.web_alb_sg.security_group_id
  security_group_id        = module.web_sg.security_group_id
}

# This is allowing traffic from Internet on port no 80 to web_alb
resource "aws_security_group_rule" "web_alb_http" {
  type              = "ingress"
  description       = "web_alb accepting traffic on 80 from Internet"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg.security_group_id
}

# This is allowing traffic from Internet on port no 443 to web_alb
resource "aws_security_group_rule" "web_alb_https" {
  type              = "ingress"
  description       = "web_alb accepting traffic on 443 from Internet"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg.security_group_id
}







