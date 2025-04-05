resource "aws_key_pair" "eks" {
  key_name   = "myec2-key-eks"
  public_key = file("myec2keyeks.pub")
  # public_key = "ssh-rsa AAAAAB3NzaC1yc2EAAAADAQABAAABAQDmU6g4fgS7k/fgrIhOt2+Hdm3Fq1O13K5FA+bRlP4xk4rYmB0lgECz7PZnXsBgbmqUynchJkeHEn3Env5tPWu6Y54I+pFwFDpvl2nqEfrm5GXStNlxNdzt4APVmQQZYxLk/KqT0QFqTPbwDHis3Lf/NKNLute6qn0uxSw6NNQJKxofGpIppgWU0mJK4MHzHMBG+CQSEDN+e2QeHxc4vK44NTdGWrfrXctXKwJl/1J2Q13iqPa+jP/MdH3v2akbebdGSOLhAXym2lB3wbeCI6Sp4CteiVLMQ4N6t33SqqAuv2bE1bCLlJcRpn/je8zrRuplYGOv0xn7HpDWWe2xL1T3== naveen@devops-laptop"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.name
  cluster_version = "1.31" # later we upgrade 1.32
  create_node_security_group = false
  create_cluster_security_group = false
  cluster_security_group_id = local.eks_control_plane_sg_id
  node_security_group_id = local.eks_node_sg_id

  #bootstrap_self_managed_addons = false
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    metrics-server = {}
  }

  # Optional
  cluster_endpoint_public_access = false

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    blue = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      #ami_type       = "AL2_x86_64"
      instance_types = ["m5.xlarge"]
      key_name = aws_key_pair.eks.key_name

      min_size     = 2
      max_size     = 10
      desired_size = 2
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEFSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        AmazonEKSLoadBalancingPolicy = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
    }
  }

  tags = merge(
    var.commn_tags,
    {
      Name = "${var.location}-${var.project_name}-${var.environment}-eks-node"
    }

  )
}