resource "aws_instance" "public_server" {
  ami = "ami-03972092c42e8c0ca"
  instance_type = "t2.micro"
  tags = {
    Name = "Public Server"
  }
  key_name = "21-Apr-24"
  subnet_id = aws_subnet.public_subnet.id
}

resource "aws_instance" "private_server" {
  ami = "ami-03972092c42e8c0ca"
  instance_type = "t2.micro"
  tags = {
    Name = "Private Server"
  }
  key_name = "21-Apr-24"
  subnet_id = aws_subnet.private_subnet.id
}

