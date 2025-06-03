resource "aws_db_subnet_group" "wordpress" {
  name       = "${var.namespace}-rds-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.namespace}-rds-subnet-group"
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.namespace}-rds-sg"
  description = "Allow MySQL/Aurora inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Only allow from VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "wordpress" {
  allocated_storage      = var.allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = var.db_parameter_group
  db_subnet_group_name   = aws_db_subnet_group.wordpress.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
}
