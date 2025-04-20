  GNU nano 6.2                                                                                                                          main.tf                                                                                                                                   
provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "ssh_http_open" {
  name        = "ssh-http-open"
  description = "Permitir SSH (22) y HTTP (80)"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "cloud9_vm" {
  ami                         = "ami-022ce79dc9cabea0c"
  instance_type               = "t2.micro"
  key_name                    = "vockey"
  vpc_security_group_ids      = [aws_security_group.ssh_http_open.id]

  root_block_device {
    volume_size = 20
  }

  tags = {
    Name = "VM-Desarrollo-Terraform"
  }
}

