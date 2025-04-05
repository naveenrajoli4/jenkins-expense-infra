
module "sg_mysql" {
  source        = "git::https://github.com/naveenrajoli4/ter-sg-module-dev.git?ref=main"
  sg_name       = "mysql"
  description   = "Created for MySQL instances in expense prod"
  location      = var.location
  project_name  = var.project_name
  environment   = var.environment
  commn_tags    = var.commn_tags
  mysql_sg_tags = var.mysql_sg_tags
  vpc_id        = data.aws_ssm_parameter.vpc_id.value
}


# Security grup for bastion server
module "sg_bastion" {
  source          = "git::https://github.com/naveenrajoli4/ter-sg-module-dev.git?ref=main"
  sg_name         = "bastion"
  description     = "Created for bastion instances in expense prod"
  location        = var.location
  project_name    = var.project_name
  environment     = var.environment
  commn_tags      = var.commn_tags
  bastion_sg_tags = var.bastion_sg_tags
  vpc_id          = data.aws_ssm_parameter.vpc_id.value
}

# VPN Ports are 22, 443, 1194, 943
module "sg_vpn" {
  source       = "git::https://github.com/naveenrajoli4/ter-sg-module-dev.git?ref=main"
  sg_name      = "vpn"
  description  = "Created for vpn in expense prod"
  location     = var.location
  project_name = var.project_name
  environment  = var.environment
  commn_tags   = var.commn_tags
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
}

# Security group for app load balancer service
module "alb_ingress_sg" {
  source       = "git::https://github.com/naveenrajoli4/ter-sg-module-dev.git?ref=main"
  sg_name      = "alb_ingress_sg"
  description  = "application load balncer ingress controller group"
  location     = var.location
  project_name = var.project_name
  environment  = var.environment
  commn_tags   = var.commn_tags
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
}

module "eks_control_plane_sg" {
  source       = "git::https://github.com/naveenrajoli4/ter-sg-module-dev.git?ref=main"
  sg_name      = "eks_control_plane_sg"
  description  = "security group for eks control plane"
  location     = var.location
  project_name = var.project_name
  environment  = var.environment
  commn_tags   = var.commn_tags
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
}

module "eks_node_sg" {
  source       = "git::https://github.com/naveenrajoli4/ter-sg-module-dev.git?ref=main"
  sg_name      = "eks_node_sg"
  description  = "security group for eks nodes"
  location     = var.location
  project_name = var.project_name
  environment  = var.environment
  commn_tags   = var.commn_tags
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
}

# Accepting traffic from eks control plane seurity group to eks nodes group 
resource "aws_security_group_rule" "eks_control_plane_eks_node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.eks_control_plane_sg.sg_id
  security_group_id        = module.eks_node_sg.sg_id  
}

# Accepting traffic from eks control plane seurity group to eks nodes group 
resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.eks_node_sg.sg_id
  security_group_id        = module.eks_control_plane_sg.sg_id
}

resource "aws_security_group_rule" "alb_ingress_eks_nodes" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  source_security_group_id       = module.alb_ingress_sg.sg_id
  security_group_id = module.eks_node_sg.sg_id
}

resource "aws_security_group_rule" "vpc_node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks = ["10.0.0.0/16"] # This hube mistake, if value is tcp, DNS will work in EKS. UDP traffic is required.So make it all traffic.
  security_group_id = module.eks_node_sg.sg_id
}

resource "aws_security_group_rule" "bastion_node" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.sg_bastion.sg_id
  security_group_id = module.eks_node_sg.sg_id
}

resource "aws_security_group_rule" "bastion_alb_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.sg_bastion.sg_id
  security_group_id = module.alb_ingress_sg.sg_id
}

resource "aws_security_group_rule" "alb_ingress_bastion_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id       = module.sg_bastion.sg_id
  security_group_id = module.alb_ingress_sg.sg_id
}

resource "aws_security_group_rule" "alb_ingress_public_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.alb_ingress_sg.sg_id
}

# JDOPS-32, Bastion host should be accessed from office n/w
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.sg_bastion.sg_id
}


resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.sg_bastion.sg_id
  security_group_id = module.sg_mysql.sg_id
}

resource "aws_security_group_rule" "mysql_eks_node" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.eks_node_sg.sg_id
  security_group_id = module.sg_mysql.sg_id
}

resource "aws_security_group_rule" "bastion_eks_control_plane" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id = module.sg_bastion.sg_id
  security_group_id = module.eks_control_plane_sg.sg_id  
}

resource "aws_security_group_rule" "alb_ingress_eks_nodes_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id       = module.alb_ingress_sg.sg_id
  security_group_id = module.eks_node_sg.sg_id
}
