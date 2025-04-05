resource "aws_lb" "ingress_alb" {
  name = "${var.location}-${var.project_name}-${var.environment}-ingress-alb"
  #   vpc_id = data.aws_ssm_parameter.vpc_id.value
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.sg_ingress_alb.value]
  subnets            = split(",", data.aws_ssm_parameter.public_subnet_ids.value)


  enable_deletion_protection = false # Prevents accidental deletion

  tags = merge(
    var.commn_tags,
    var.web_alb_tags,
    {
      Name = "${var.location}-${var.project_name}-${var.environment}-ingress-alb"
    }

  )
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.ingress_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_ssm_parameter.ingress_alb_certificate_arn.value

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hello, I am from frontend ingress ALB with HTTPS</h1>"
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "ingress_alb" {
  zone_id = var.zone_id
  name    = "expense-${var.environment}.${var.domain_name}"
  type    = "A"

  # These are ALB DNS names and zone id information
  alias {
    name                   = aws_lb.ingress_alb.dns_name
    zone_id                = aws_lb.ingress_alb.zone_id
    evaluate_target_health = false
  }
}


resource "aws_lb_listener_rule" "frontend" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
  }
  condition {
    host_header {
      values = ["expense-${var.environment}.${var.domain_name}"]
    }
  }
}

resource "aws_lb_target_group" "frontend_target_group" {
  name        = "${var.location}-${var.project_name}-${var.environment}-frontend-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value
  target_type = "ip"
  deregistration_delay = 60

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = 8080
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher = "200-299"
  }
  
}