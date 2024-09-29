terraform {
  backend "s3" {
    bucket = "ADD_BUCKET_NAME_HERE"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "DYNAMO_DB_TABLE_NAME_HERE"
  }
}
