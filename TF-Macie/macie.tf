resource "aws_macie2_account" "admin" {
    count  = var.enable_macie ? 1 : 0
    status = "ENABLED"
}

output "account-id" {
    value = aws_macie2_account.admin.id
}

output "account-created" {
    value = aws_macie2_account.admin.created_at
}

resource "aws_macie2_classification_job" "test" {
  job_type = "ONE_TIME"
  name     = "Testing Macie's PII detection"
  s3_job_definition {
    bucket_definitions {
      account_id = aws_macie2_account.admin.id
      buckets    = [aws_s3_bucket.demo.id]
    }
  }
  depends_on = [aws_macie2_account.admin]
}