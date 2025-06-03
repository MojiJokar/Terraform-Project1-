output "rds_endpoint" {
  value = aws_db_instance.wordpress.endpoint
}
output "rds_username" {
  value = aws_db_instance.wordpress.username
}
