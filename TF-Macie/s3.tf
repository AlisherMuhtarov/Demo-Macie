resource "aws_s3_bucket" "demo" {
  bucket = "macie-monitered-s3-bucket"

  tags = {
    Name        = "macie-bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "private" {
  bucket = aws_s3_bucket.demo.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "private" {
  depends_on = [aws_s3_bucket_ownership_controls.private]

  bucket = aws_s3_bucket.demo.id
  acl    = "private"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.demo.id
  key    = "PII"
  source = ["../PII-Files/dummy_info_1", "../PII-Files/dummy_info_2", "../PII-Files/dummy_info_3", "../PII-Files/dummy_info_4", "../PII-Files/dummy_info_5"]
}