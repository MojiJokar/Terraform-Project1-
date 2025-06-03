# modules/ebs/main.tf
resource "aws_ebs_volume" "data_volume" {
  availability_zone = var.availability_zone
  size              = var.size
  type              = var.type
  tags = {
    Name = "${var.namespace}-ebs-data"
  }
}


# modules/ebs/variables.tf
variable "namespace" {}
variable "availability_zone" {}
variable "size" { default = 10 }
variable "type" { default = "gp2" }
