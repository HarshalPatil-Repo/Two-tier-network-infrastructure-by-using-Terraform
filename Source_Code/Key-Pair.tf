# RSA key of size 4096 bits for generating PEM file
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

variable "key_name" {}

resource "aws_key_pair" "TF_Key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa.public_key_openssh 
}

resource "local_file" "TF_Key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.key_name
}