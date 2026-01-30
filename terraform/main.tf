provider "aws" {
  region = "ap-south-1"
}

# 🔐 Security Group for SSH + HTTP
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow-ssh-http"
  description = "Allow SSH and HTTP access"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
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

  tags = {
    Name = "day20-sg"
  }
}

# 🖥️ EC2 Instance
resource "aws_instance" "app" {
  ami                    = "ami-0f5ee92e2d63afc18"
  instance_type          = "t2.micro"
  key_name               = "day20-key"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  tags = {
    Name = "day20-tf-ansible-ec2"
  }
}

# 📤 Output Public IP

