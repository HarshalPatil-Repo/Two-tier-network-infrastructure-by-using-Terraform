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