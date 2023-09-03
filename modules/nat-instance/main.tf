
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
    }
  }

  required_version = ">= 0.14.9"
}

resource "aws_security_group" "security_group" {
  name        = "${var.name}_security_group"
  description = "Security group for NAT instance ${var.name}"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Ingress CIDR"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = [var.vpc_cidr_ipv4]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]

  egress = [
    {
      description      = "Default egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]
}

resource "aws_instance" "nat_instance" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  count         = 1
  key_name      = var.ssh_key
  network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
  }
  user_data = <<EOT
#!/bin/bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo yum install -y iptables-services
sudo service iptables save
  EOT

  tags = {
    Name = var.name
    Role = "nat"
  }
}

# use this network interface for the private subnet route table route
resource "aws_network_interface" "network_interface" {
  subnet_id         = var.subnet_id
  source_dest_check = false
  security_groups   = [aws_security_group.security_group.id]

  tags = {
    Name = "${var.name}_network_interface"
  }
}

resource "aws_eip" "nat_public_ip" {
  instance = aws_instance.nat_instance[0].id
  domain   = "vpc"
}

resource "aws_route_table" "pvt_rtb" {
  vpc_id = var.vpc_id

  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.network_interface.id
  }

  tags = {
    Name = "nat-pvt-rtb"
  }
}

resource "aws_route_table_association" "pvt_rtb_attach" {
  count          = length(var.pvt_subnet_ids)
  subnet_id      = var.pvt_subnet_ids[count.index]
  route_table_id = aws_route_table.pvt_rtb.id
}
