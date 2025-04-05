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

variable "web_alb_tags" {
  default = {
    Reason = "Created for backend app ALB"
  }
}

variable "zone_id" {
  default = "Z09769147H1JY4GOARUG"
}

variable "domain_name" {
  default = "naveenrajoli.site"
}