resource "aws_ssm_parameter" "sg_mysql_id" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/sg_mysql_id"
  type  = "String"
  value = module.sg_mysql.sg_id
}

resource "aws_ssm_parameter" "sg_bastion_id" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/sg_bastion_id"
  type  = "String"
  value = module.sg_bastion.sg_id
}

resource "aws_ssm_parameter" "sg_vpn_id" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/sg_vpn_id"
  type  = "String"
  value = module.sg_vpn.sg_id
}

resource "aws_ssm_parameter" "alb_ingress_sg_id" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/alb_ingress_sg_id"
  type  = "String"
  value = module.alb_ingress_sg.sg_id
}

resource "aws_ssm_parameter" "eks_control_plane_sg_id" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/eks_control_plane_sg_id"
  type  = "String"
  value = module.eks_control_plane_sg.sg_id
}

resource "aws_ssm_parameter" "eks_node_sg_id" {
  name  = "/${var.location}/${var.project_name}/${var.environment}/eks_node_sg_id"
  type  = "String"
  value = module.eks_node_sg.sg_id
}
