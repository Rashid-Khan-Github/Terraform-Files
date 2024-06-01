output "vpc_id" {
  value = module.vpc.vpc_id         # module.<resource-name>.<output-variable-name>
}

# output "azs_info_out" {
#   value = module.vpc_adv.azs_output
# }

# output "public_sub_ids" {
#   value = local.public_subnet_ids
# }

# output "private_subnet_ids" {
#   value = local.private_subnet_ids
# }

# output "database_subnet_ids" {
#   value = local.database_subnet_ids
# }

# output "ami_id_value" {
#   value = data.aws_ami.devops_ami
# }

output "instances" {
  value = local.instances_output
}

