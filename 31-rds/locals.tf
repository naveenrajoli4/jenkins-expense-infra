locals {
  resource_name   = "${var.location}-${var.project_name}-${var.environment}-rds"
  sg_mysql_id     = data.aws_ssm_parameter.sg_mysql_id.value
  db_subnet_group = data.aws_ssm_parameter.db_subnet_group.value
}