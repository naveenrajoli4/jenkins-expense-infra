# output "vpc-info" {
#     value = module.expense_vpc.vpc-info
# }

# output "az_info" {
#     value = module.expense_vpc.az_info
# }

output "eip" {
  value = module.expense_vpc.eip
}

output "rpub" {
  value = module.expense_vpc.rpub
}

output "igw" {
  value = module.expense_vpc.igw
}

output "default_vpc_info" {
  value = module.expense_vpc.default_vpc_info
}

output "peering_info" {
  value = module.expense_vpc.peering_info
}

output "public_subnet_ids" {
  value = module.expense_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.expense_vpc.private_subnet_ids
}

output "database_subnet_ids" {
  value = module.expense_vpc.database_subnet_ids
}



