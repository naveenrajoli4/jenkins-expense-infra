locals {
  instncetype       = "t3.micro"
  public_subnet_ids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

}