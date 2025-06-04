variable "namespace" { type = string }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "db_name" { type = string }
variable "db_username" { type = string }
#variable "db_password" { type = string }
# to have sensitive values , use sensitive ture 
variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_port" { default = 3306, type = number }
variable "db_engine" { default = "mysql", type = string }
variable "db_engine_version" { default = "5.7", type = string }
variable "db_instance_class" { default = "db.t2.micro", type = string }
variable "allocated_storage" { default = 10, type = number }
variable "db_parameter_group" { default = "default.mysql5.7", type = string }
