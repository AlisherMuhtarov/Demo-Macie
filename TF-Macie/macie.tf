resource "aws_macie2_account" "admin" {
    count  = var.enable_macie ? 1 : 0
    status = "ENABLED"
}

resource "aws_macie2_classification_job" "test" {
  job_type = "ONE_TIME"
  name     = "Testing Macie's PII detection"
  s3_job_definition {
    bucket_definitions {
      account_id = "${data.aws_caller_identity.current.account_id}"
      buckets    = [aws_s3_bucket.demo.bucket]
    }
  }
  depends_on = [aws_macie2_account.admin]
}
