terraform {

  required_version = ">= 0.12"

}

resource "aws_s3_bucket" "bucket" {
    bucket = "${var.bucket_name}"-"${var.env_type}"

    
  
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"

}