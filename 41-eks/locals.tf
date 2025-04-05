locals {
  name = "${var.location}-${var.project_name}-${var.environment}-eks"
  vpc_id = data.aws_ssm_parameter.vpcid.value
  private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  eks_control_plane_sg_id = data.aws_ssm_parameter.eks_control_plane_sg_id.value
  eks_node_sg_id = data.aws_ssm_parameter.eks_node_sg_id.value
}
