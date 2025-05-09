resource "aws_acm_certificate" "expense_acm" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  tags = merge (
    var.commn_tags,
    {
        Name = "${var.location}-${var.project_name}-${var.environment}-acm"
    }
  )

 }

resource "aws_route53_record" "expense" {
  for_each = {
    for dvo in aws_acm_certificate.expense_acm.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

# Validate the certificate
resource "aws_acm_certificate_validation" "acm_validation" {
  certificate_arn         = aws_acm_certificate.expense_acm.arn
  validation_record_fqdns = [for record in aws_route53_record.expense : record.fqdn]
}