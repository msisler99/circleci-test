terraform {
  backend "s3" {
    bucket = "ttg-tf-test-bucket"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
