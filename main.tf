terraform {
    required_providers {
       aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
}
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "Test" {
    instance_type="t3.micro"
    ami="ami-0cbbe2c6a1bb2ad63"
  vpc_security_group_ids = [aws_security_group.Test_Terraform.id]
tags = {
    Name = "Test-Instance"
  }
}

resource "aws_security_group" "Test_Terraform" {
    name = "TestTerraform"
    vpc_id = "vpc-0160f4b6e385a12e0"
    description = "Terraformtest"

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
    Name = "example-sg"
  }
}