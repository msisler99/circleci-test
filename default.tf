provider "aws" {
  region     = "us-west-2"
}
 
 resource "aws_vpc" "minimal" { 
   cidr_block = "10.0.0.0/28" 
   tags { 
     Name = "minimal" 
   } 
  } 
 