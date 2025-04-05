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

variable "zone_id" {
  default = "Z09769147H1JY4GOARUG"
}

variable "domain_name" {
  default = "naveenrajoli.site"
}