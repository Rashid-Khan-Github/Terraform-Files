locals {
  vpc_id              = module.vpc_adv.vpc_id
  public_subnet_ids   = module.vpc_adv.public_subnet_ids
  private_subnet_ids  = module.vpc_adv.private_subnet_ids
  database_subnet_ids = module.vpc_adv.database_subnet_ids
}
