# WE ALSO CAN HAVE 

variable "namespace" {
  description = "The project namespace to be used for the unique naming of resources"
  default     = "Datas*******"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "****-west-3"
  type        = string
}


variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "Username for the database"
  type        = string
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}


