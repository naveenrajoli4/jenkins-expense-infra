data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.location}/${var.project_name}/${var.environment}/vpcid"
}