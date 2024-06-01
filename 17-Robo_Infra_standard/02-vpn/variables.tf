variable "project_name" {
  default = "roboshop"
}

variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Environment = "DEV"
    Terraform   = true
  }
}

variable "env" {
  default = "dev"
}



