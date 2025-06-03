# In modules/ec2/outputs.tf
output "ec2_public_id" {
  value = aws_instance.ec2_public.id
}
output "ec2_public_az" {
  value = aws_instance.ec2_public.availability_zone
}
