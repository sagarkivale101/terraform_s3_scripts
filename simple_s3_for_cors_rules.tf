variable "s3_bucket_names" {
  type = list
  default = ["test1", "test2"]
}

provider "aws" {
  
	region = "ap-south-1"
}



resource "aws_s3_bucket" "b" {
  count         = length(var.s3_bucket_names) 
  bucket        = var.s3_bucket_names[count.index]
  acl           = "private"
  

  # cors rules which will be applied on bucket objects
  cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST", "DELETE", "GET"]
        allowed_origins = ["*"]
        expose_headers  = []
  }
 
}