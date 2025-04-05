variable "location" {
  default = "kdp"
}

variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "prod"
}



variable "commn_tags" {
  default = {
    Owner       = "Naveen Rajoli"
    project     = "expense-app"
    Location    = "kadapa-AP"
    Environment = "production"
  }
}

variable "mysql_sg_tags" {
  default = {
    Reason = "Security group for MySQL"
  }
}

variable "backend_sg_tags" {
  default = {
    Reason = "Security group for backend"
  }
}

variable "frontend_sg_tags" {
  default = {
    Reason = "Security group for frontend"
  }
}

variable "bastion_sg_tags" {
  default = {
    Reason = "Security group for bastion"
  }
}