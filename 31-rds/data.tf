data "aws_ssm_parameter" "sg_mysql_id" {
  name = "/${var.location}/${var.project_name}/${var.environment}/sg_mysql_id"
}

data "aws_ssm_parameter" "db_subnet_group" {
  name = "/${var.location}/${var.project_name}/${var.environment}/db_subnet_group"
}

