provider "aws" {
  region     = "eu-north-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "EC2-Instance" {
  availability_zone      = "eu-north-1a"
  ami                    = "ami-0fe8bec493a81c7da"
  instance_type          = "t3.micro"
  key_name               = "oban"
  vpc_security_group_ids = [aws_security_group.DefaultTerraformSG.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "standard"
    tags = {
      Name = "root-disk"
    }
  }
}

resource "aws_instance" "EC2-Instance2" {
  availability_zone      = "eu-north-1a"
  ami                    = "ami-0fe8bec493a81c7da"
  instance_type          = "t3.micro"
  key_name               = "oban"
  vpc_security_group_ids = [aws_security_group.DefaultTerraformSG.id]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 11 
    volume_type = "standard"
    tags = {
      Name = "root-disk-instance2"
    }
  }
}

resource "aws_security_group" "DefaultTerraformSG" {
  name        = "DefaultTerraformSG"
  description = "Allow 22, 80, 443 inbound taffic"

  dynamic "ingress" {
    for_each = ["22", "80", "443", "8080", "8000"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
