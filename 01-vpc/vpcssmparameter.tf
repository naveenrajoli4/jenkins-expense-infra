resource "aws_ssm_parameter" "vc_id" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/vpcid"
  type  = "String"
  value = module.expense_vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  value = join(",", module.expense_vpc.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  value = join(",", module.expense_vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  value = join(",", module.expense_vpc.database_subnet_ids)
}

resource "aws_ssm_parameter" "db_subnet_group" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/db_subnet_group"
  type  = "String"
  value = aws_db_subnet_group.db_subnet_group.name
}