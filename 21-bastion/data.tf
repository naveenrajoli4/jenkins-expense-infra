data "aws_ami" "rhel9" {
  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.location}/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "sg_bastion_id" {
  name = "/${var.location}/${var.project_name}/${var.environment}/sg_bastion_id"
}

output "ami-id" {
  value = data.aws_ami.rhel9.id
}


