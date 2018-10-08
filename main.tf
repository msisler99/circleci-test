provider "aws" {
  access_key = "AKIAJJRVJORZGA5BYVOA"
  secret_key = "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"
  region     = "us-west-2"
}
 
 resource "aws_vpc" "minimal" { 
   cidr_block = "10.0.0.0/28" 
   tags { 
     Name = "minimal" 
   } 
  } 
 
resource "aws_s3_bucket" "b" {
  bucket = "ttg-tf-test-bucket"
  acl    = "private"

  tags {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
 	
