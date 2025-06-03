#Create a Data Source aws_ami to select the friend available in your region
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
# Configure EC2 instance in a public subnet
resource "aws_instance" "ec2_public" {
  ami = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = var.vpc.public_subnets[0]
  vpc_security_group_ids = [var.sg_pub_id]
  user_data = file("install_wordpress.sh")

  tags = {
    "Name" = "${var.namespace}-EC2-PUBLIC"
  }
}
# Configure EC2 instance in a private subnet
resource "aws_instance" "ec2_private" {
  ami = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = false
  instance_type = "t2.micro"
  key_name = var.key_name
  subnet_id = var.vpc.private_subnets[1]
  vpc_security_group_ids = [var.sg_priv_id]

  tags = {
    "Name" = "${var.namespace}-EC2-PRIVATE"
  }
}

# to  be persistent storage for  ec2
resource "aws_ebs_volume" "wordpress_data" {
  availability_zone = aws_instance.ec2_public.availability_zone
  size              = 10
  type              = "gp2"
  tags = {
    Name = "${var.namespace}-wordpress-data"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.wordpress_data.id
  instance_id = aws_instance.ec2_public.id
}

module "ebs" {
  source             = "./modules/ebs"
  namespace          = var.namespace
  availability_zone  = module.ec2.ec2_public_az
  # or, if you want to use the private instance, use module.ec2.ec2_private_az
  # Ensure you output the availability_zone from your ec2 module
  size               = 10
  type               = "gp2"
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs.volume_id
  instance_id = module.ec2.ec2_public_id
  # or, if you want to attach to the private instance, use module.ec2.ec2_private_id
  # Ensure you output the instance IDs from your ec2 module
}
