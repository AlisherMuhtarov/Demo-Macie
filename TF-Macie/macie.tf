resource "aws_macie2_account" "local" {
    count  = var.enable_macie ? 1 : 0
    status = "ENABLED"
}

resource "aws_macie2_classification_job" "test" {
  job_type = "ONE_TIME"
  name     = "PII-Demo-${timestamp()}"
  sampling_percentage = 100
  s3_job_definition {
    bucket_definitions {
      account_id = "${data.aws_caller_identity.current.account_id}"
      buckets    = [aws_s3_bucket.demo.id]
    }
  }
  depends_on = [aws_macie2_account.local]
}
