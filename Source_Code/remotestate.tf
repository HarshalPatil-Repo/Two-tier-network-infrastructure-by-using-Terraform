terraform {
  backend "s3" {
    bucket = "tfstate-management-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "StateLock"
  }
}
