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