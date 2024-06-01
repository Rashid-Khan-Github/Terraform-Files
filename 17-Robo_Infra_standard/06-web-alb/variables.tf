variable "project_name" {
  default = "roboshop"
}

variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Component   = "web-alb"
    Environment = "DEV"
    Terraform   = true
  }
}

variable "env" {
  default = "dev"
}
