data "aws_cloudfront_cache_policy" "noCache" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "cacheEnable" {
  name = "Managed-CachingOptimized"
}

data "aws_ssm_parameter" "ingress_alb_certificate_arn" {
  name = "/${var.location}/${var.project_name}/${var.environment}/ingress_alb_certificate_arn"
}
