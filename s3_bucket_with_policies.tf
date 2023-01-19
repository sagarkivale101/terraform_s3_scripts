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
  
  #this policy will make object in bucket public
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
 
   
  versioning {
      enabled = true
  }
  
}