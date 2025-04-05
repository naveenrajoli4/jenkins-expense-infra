
data "aws_ssm_parameter" "vpcid" {
  name = "/${var.location}/${var.project_name}/${var.environment}/vpcid"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.location}/${var.project_name}/${var.environment}/private_subnet_ids"
}


data "aws_ssm_parameter" "eks_control_plane_sg_id" {
  name = "/${var.location}/${var.project_name}/${var.environment}/eks_control_plane_sg_id"
}

data "aws_ssm_parameter" "eks_node_sg_id" {
  name = "/${var.location}/${var.project_name}/${var.environment}/eks_node_sg_id"
}
