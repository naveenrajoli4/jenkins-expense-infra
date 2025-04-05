locals{
    https_certificate_arn = data.aws_ssm_parameter.ingress_alb_certificate_arn.value
}