terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }
  }

  backend "s3" {
    bucket         = "my-robo-bucket"
    key            = "user"
    region         = "us-east-1"
    dynamodb_table = "robo-locking"
  }

}

provider "aws" {
  region = "us-east-1"
}