# resource "aws_db_instance" "rds" {

#   identifier        = local.resource_name
#   engine            = "mysql"
#   engine_version    = "8.0.40"
#   instance_class    = "db.t4g.micro"
#   allocated_storage = 20

#   db_name                     = "transactions" # AWS will create this schema automatically
#   username                    = "root"
#   port                        = "3306"
#   password                    = "ExpenseApp1"
#   manage_master_user_password = false

#   vpc_security_group_ids = [local.sg_mysql_id]

#   # DB subnet group
#   db_subnet_group_name   = local.db_subnet_group

#   # DB parameter group
#   family = "mysql8.0"

#   # DB option group
#   major_engine_version = "8.0"

#   # Database Deletion Protection
#   deletion_protection = false
#   skip_final_snapshot = true

#   parameters = [
#     {
#       name  = "character_set_client"
#       value = "utf8mb4"
#     },
#     {
#       name  = "character_set_server"
#       value = "utf8mb4"
#     }
#   ]

#   options = [
#     {
#       option_name = "MARIADB_AUDIT_PLUGIN"

#       option_settings = [
#         {
#           name  = "SERVER_AUDIT_EVENTS"
#           value = "CONNECT"
#         },
#         {
#           name  = "SERVER_AUDIT_FILE_ROTATIONS"
#           value = "37"
#         },
#       ]
#     },
#   ]

#   tags = merge(
#     var.commn_tags,
#     {
#       Name = local.resource_name
#     }
#   )
# }

# # resource "aws_route53_record" "mysql_r53" {
# #   zone_id = var.zone_id
# #   name    = "${local.resource_name}.${var.domain_name}"
# #   type    = "CNAME"
# #   ttl     = 5
# #   records = [module.db.db_instance_address]
# # }

# output "test" {
#   value = aws_db_instance.rds
# }
