resource "aws_key_pair" "k8s_key" {
  key_name   = "k8s-key"
  public_key = file("/Users/haripalepu/Downloads/k8s.pub")
}

#Master Node 1
resource "aws_instance" "master01" {
  ami                         = "ami-0cd59ecaf368e5ccf"
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.k8s_key.key_name
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = [aws_security_group.allow_all.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 15
  }

  tags = {
    Name       = "master01"
    Env        = "Prod"
    Owner      = "hari"
    CostCenter = "ABCD"
  }

  user_data = <<-EOF
        #!/bin/bash
        sudo curl https://get.docker.com | bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        sudo reboot
  EOF
}

#Master Node 2
resource "aws_instance" "master02" {
  ami                         = "ami-0cd59ecaf368e5ccf"
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.k8s_key.key_name
  subnet_id                   = aws_subnet.subnet2-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  root_block_device {
    volume_size = 15
  }
  tags = {
    Name       = "master02"
    Env        = "Prod"
    Owner      = "hari"
    CostCenter = "ABCD"
  }
	user_data = <<-EOF
        #!/bin/bash
        sudo curl https://get.docker.com | bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        sudo reboot
	EOF
}

#Master Node 3
resource "aws_instance" "master03" {
  ami                         = "ami-0cd59ecaf368e5ccf"
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.k8s_key.key_name
  subnet_id                   = aws_subnet.subnet3-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  root_block_device {
    volume_size = 15
  }
  tags = {
    Name       = "master03"
    Env        = "Prod"
    Owner      = "hari"
    CostCenter = "ABCD"
  }
	user_data = <<-EOF
        #!/bin/bash
        sudo curl https://get.docker.com | bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        sudo reboot
	EOF
}

#Worker Node 1
resource "aws_instance" "worker01" {
  ami                         = "ami-0cd59ecaf368e5ccf"
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.k8s_key.key_name
  subnet_id                   = aws_subnet.subnet1-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  root_block_device {
    volume_size = 15
  }
  tags = {
    Name       = "worker01"
    Env        = "Prod"
    Owner      = "hari"
    CostCenter = "ABCD"
  }
	user_data = <<-EOF
        #!/bin/bash
        sudo curl https://get.docker.com | bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        sudo reboot
	EOF
}

#Worker Node 2
resource "aws_instance" "worker02" {
  ami                         = "ami-0cd59ecaf368e5ccf"
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.k8s_key.key_name
  subnet_id                   = aws_subnet.subnet2-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  root_block_device {
    volume_size = 15
  }
  tags = {
    Name       = "worker02"
    Env        = "Prod"
    Owner      = "hari"
    CostCenter = "ABCD"
  }
	user_data = <<-EOF
        #!/bin/bash
        sudo curl https://get.docker.com | bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        sudo reboot
	EOF
}

#Worker Node 3
resource "aws_instance" "worker03" {
  ami                         = "ami-0cd59ecaf368e5ccf"
  instance_type               = "t3.medium"
  key_name                    = aws_key_pair.k8s_key.key_name
  subnet_id                   = aws_subnet.subnet3-public.id
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  root_block_device {
    volume_size = 15
  }
  tags = {
    Name       = "worker03"
    Env        = "Prod"
    Owner      = "hari"
    CostCenter = "ABCD"
  }
	user_data = <<-EOF
        #!/bin/bash
        sudo curl https://get.docker.com | bash
        sudo usermod -a -G docker ubuntu
        sudo usermod -a -G root ubuntu
        sudo systemctl daemon-reload
        sudo systemctl restart docker
        sudo reboot
	EOF
}