# define AWS provider

provider "aws" {
  region     = var.aws_region
  version    = "~> 2.0"
}

# Create Network

resource "aws_vpc" "vpc_devops" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_route" "access_IGW" {
  route_table_id = aws_vpc.vpc_devops.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_devops.id
}

resource "aws_subnet" "sub_public_devops" {
  vpc_id     = aws_vpc.vpc_devops.id
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_security_group" "sg_devops" {
  name        = "sg_devops"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.vpc_devops.id

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create key pair

resource "aws_key_pair" "kp_devops" {
  key_name   = "kp_devops"
  public_key = var.public_sshkey
}

resource "aws_instance" "ec2_devops" {
  ami           = var.image
  instance_type = var.type
  key_name = aws_key_pair.kp_devops.key_name
  vpc_security_group_ids = [aws_security_group.sg_devops.id]
  subnet_id = aws_subnet.sub_public_devops.id
  associate_public_ip_address = true
  depends_on = [aws_internet_gateway.gw]
}

output "ec2_devops_public_ip" {
  value = aws_instance.ec2_devops.public_ip
}
