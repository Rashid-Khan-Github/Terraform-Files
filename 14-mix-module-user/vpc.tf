module "vpc_adv" {
  
  source               = "../13-vpc-module-advanced"
  cidr_block           = var.cidr_block
  project_name         = var.project_name
  vpc_tags             = var.vpc_tags
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
  database_subnet_cidr = var.database_subnet_cidr

}