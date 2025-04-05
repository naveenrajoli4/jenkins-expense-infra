data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.location}/${var.project_name}/${var.environment}/vpcid"
}

data "aws_ssm_parameter" "sg_ingress_alb" {
  name = "/${var.location}/${var.project_name}/${var.environment}/alb_ingress_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.location}/${var.project_name}/${var.environment}/public_subnet_ids"
}


data "aws_ssm_parameter" "ingress_alb_certificate_arn" {
  name = "/${var.location}/${var.project_name}/${var.environment}/ingress_alb_certificate_arn"
}