resource "aws_ssm_parameter" "ingress_alb_certificate_arn" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/ingress_alb_certificate_arn"
  type  = "String"
  value = aws_acm_certificate.expense_acm.arn
}