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

