resource "aws_db_instance" "rdb" {
  identifier        = local.resource_name
  engine            = "mysql"
  engine_version    = "8.0.40"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  db_name  = "transactions" # AWS will create this schema automatically
  username = "root"
  password = "ExpenseApp1"
  port     = 3306

  db_subnet_group_name   = local.db_subnet_group
  vpc_security_group_ids = [local.sg_mysql_id]

  parameter_group_name = "default.mysql8.0"

  deletion_protection = false
  skip_final_snapshot = true

  tags = merge(
    var.commn_tags,
    {
      Name = local.resource_name
    }
  )
}

# DB Parameter Group
resource "aws_db_parameter_group" "db_param_group" {
  name   = "${local.resource_name}-param-group"
  family = "mysql8.0"

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

# DB Option Group
resource "aws_db_option_group" "db_option_group" {
  name                 = "${local.resource_name}-option-group"
  engine_name          = "mysql"
  major_engine_version = "8.0"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"

    option_settings {
      name  = "SERVER_AUDIT_EVENTS"
      value = "CONNECT"
    }

    option_settings {
      name  = "SERVER_AUDIT_FILE_ROTATIONS"
      value = "37"
    }
  }
}

resource "aws_route53_record" "r53_rds" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 5
  records = [aws_db_instance.rdb.address]
}

# output "test" {
#   value = aws_db_instance.rds.address
# }

output "rds_endpoint" {
  sensitive = true
  value     = aws_db_instance.rdb.address
}
