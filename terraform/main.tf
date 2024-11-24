provider "aws" {
  region = "ap-south-2"
}

# VPC configuration
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Subnet configuration
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

# EC2 instance for Kubernetes
resource "aws_instance" "k8s_master" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
}

resource "aws_security_group" "k8s_sg" {
  name_prefix = "k8s_sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
