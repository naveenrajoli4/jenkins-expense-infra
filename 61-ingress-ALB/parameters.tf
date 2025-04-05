resource "aws_ssm_parameter" "ingress_alb_listner_arn" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/ingress_alb_listner_arn"
  type  = "String"
  value = aws_lb_listener.https.arn
}