variable "location" {
  default = "kdp"
}

variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "prod"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "commn_tags" {
  default = {
    Owner       = "Naveen Rajoli"
    project     = "expense-app"
    Location    = "kadapa-AP"
    Environment = "production"
  }
}

variable "vpc_tags" {
  default = {
    Purpose = "VPC-creation-for-expense"
    Reason  = "For-security"
  }
}

variable "igw_tags" {
  default = {
    Purpose = "IGW-creation-for-expense"
    Reason  = "For-security"
  }
}

variable "public_subnet_cidr" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "public_subet_tags" {
  default = {
    Purpose = "public-subet-creation-for-expense"
    "kubernetes.io/role/elb" = "1"
  }
}

variable "private_subnet_cidr" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}
variable "private_subnet_tags" {
  default = {
    Purpose = "private-subet-creation-for-expense"
  }
}

variable "database_subnet_cidr" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}
variable "database_subnet_tags" {
  default = {
    Purpose = "database-subet-creation-for-expense"
  }
}

variable "public_route_table_tags" {
  default = {
    Purpose = "public-route-table-creation-for-expense"
  }
}

variable "private_route_table_tags" {
  default = {
    Purpose = "private-route-table-creation-for-expense"
  }
}

variable "database_route_table_tags" {
  default = {
    Purpose = "database-route-table-creation-for-expense"
  }
}
