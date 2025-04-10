resource "aws_instance" "this" {
  ami                    = data.aws_ami.rhel9.id  # This is our devops-practice AMI ID
  instance_type          = local.instncetype
  vpc_security_group_ids = [data.aws_ssm_parameter.sg_bastion_id.value]
  subnet_id              = local.public_subnet_ids

  # 20GB is not enough
  root_block_device {
    volume_size = 50  # Set root volume size to 50GB
    volume_type = "gp3"  # Use gp3 for better performance (optional)
    delete_on_termination = true
  }
  user_data = file("jenkins-agent.sh")
  tags = merge(
    var.commn_tags,
    {
      Name = "${var.location}-${var.project_name}-${var.environment}-bastion"
    }

  )
}

