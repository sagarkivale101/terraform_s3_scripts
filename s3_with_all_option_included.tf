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
  

  policy = <<EOF
        {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "PublicReadGetObject",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::${var.s3_bucket_names[count.index]}/*"
            }
        ]
    }
        EOF
  website {
        index_document = "index.html"
        error_document = "404.html"
    }
   
  versioning {
      enabled = true
   }
  tags = {
     Name = "frontend-buckets"
     Environment = "dev"
   }
   cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT", "POST", "DELETE", "GET"]
        allowed_origins = ["*"]
        expose_headers  = []
    }
  force_destroy = true
}