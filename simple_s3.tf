
provider "aws" {
  
	region = "ap-south-1"
}


variable "s3_bucket_names" {
  type = list
  default = ["test1", "test2"]  # array so we can give multiple bucket names
}


resource "aws_s3_bucket" "b" {
  count         = length(var.s3_bucket_names) 
  bucket        = var.s3_bucket_names[count.index]
  acl           = "private"
  
}