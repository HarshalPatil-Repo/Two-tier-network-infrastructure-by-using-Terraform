# VPC

resource "aws_vpc" "my-VPC" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "my-VPC"
  }
}

# Public and Private Subnets

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my-VPC.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my-VPC.id
  cidr_block = "10.10.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Private Subnet"
  }
}


# Internet Gateway

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my-VPC.id

  tags = {
    Name = "myIGW"
  }
}

# NAT Gateway

resource "aws_eip" "lb" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "my_NATGW" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "myNATGW"
  }

  // To ensure proper ordering, it is recommended to add an explicit dependency
  // on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my_igw]
}

# Main Route Table and Custom Route Table with respective subnet association

resource "aws_route_table" "MRT" {
  vpc_id = aws_vpc.my-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "MRT"
  }
}

resource "aws_route_table" "CRT" {
  vpc_id = aws_vpc.my-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_NATGW.id
  }

  tags = {
    Name = "CRT"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.MRT.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.CRT.id
}

# Security Group

resource "aws_security_group" "my-SG" {
  name        = "my-SG"
  description = "Security Group using Terraform"
  vpc_id      = aws_vpc.my-VPC.id

  tags = {
    Name = "my-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "HTTPS" {
  security_group_id = aws_security_group.my-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "HTTP" {
  security_group_id = aws_security_group.my-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "SSH" {
  security_group_id = aws_security_group.my-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "All_Traffic" {
  security_group_id = aws_security_group.my-SG.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" // semantically equivalent to all ports
}

# SSH Key-Pair Generation

// RSA key of size 4096 bits for generating PEM file
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "TF_Key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh 
}

resource "local_file" "TF_Key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.key_name
}

# Public and Private EC2 Instances

resource "aws_instance" "public_server" {
  ami = "ami-03972092c42e8c0ca"
  instance_type = "t2.micro"
  key_name = aws_key_pair.TF_Key.key_name
  security_groups = [ aws_security_group.my-SG.id ]
  tags = {
    Name = "Public Server"
  }
  subnet_id = aws_subnet.public_subnet.id
}

resource "aws_instance" "private_server" {
  ami = "ami-03972092c42e8c0ca"
  instance_type = "t2.micro"
  key_name = aws_key_pair.TF_Key.key_name
  security_groups = [ aws_security_group.my-SG.id ]
  tags = {
    Name = "Private Server"
  }
  subnet_id = aws_subnet.private_subnet.id
}

