provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "demo_sg" {
  name        = "demo-security-group"
  description = "Allow SSH"

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo_ec2" {
  ami                    = "ami-053b12d3152c0cc71"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  tags = {
    Name = "Terraform-Demo-Server"
  }
}