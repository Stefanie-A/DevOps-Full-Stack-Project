#ssh key pair
resource "tls_private_key" "key-pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "ssh-key" {
  key_name   = var.key_name
  public_key = tls_private_key.key-pair.public_key_openssh
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh-key.key_name
  security_groups = [aws_security_group.ec2_sg.id]
  subnet_id       = aws_subnet.public_subnet[0].id
  user_data = <<-EOF
    #!/bin/bash
    sudo su
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install nginx -y
    sudo systemctl start nginx
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker ubuntu
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
    npm install -g pm2

  EOF
  tags = {
    Name = "kox"
  }
}

#security group
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #don't allow all ip address to ssh in prod
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sr-security_group"
  }
}

# Observability Instance
resource "aws_instance" "Observability_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh-key.key_name
  security_groups = [aws_security_group.obs_sg.id]
  subnet_id       = aws_subnet.public_subnet[0].id
  # user_data                   = file("${path.module}/user_data.sh")
  associate_public_ip_address = true
  tags = {
    Name = "observability_instance"
  }
}

#security group
resource "aws_security_group" "obs_sg" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #don't allow all ip address to ssh in prod
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "obs-security_group"
  }
}
