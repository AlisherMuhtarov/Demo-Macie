resource "aws_macie2_account" "local" {
    count  = var.enable_macie ? 1 : 0
    status = "ENABLED"
}

resource "aws_macie2_classification_job" "test" {
  job_type = "ONE_TIME"
  name     = "PII-Detection-${timestamp()}"
  initial_run = true
  sampling_percentage = 10
  s3_job_definition {
    bucket_definitions {
      account_id = "${data.aws_caller_identity.current.account_id}"
      buckets    = [aws_s3_bucket.demo.id]
    }
  }
  depends_on = [aws_macie2_account.local]
}

resource "aws_macie2_custom_data_identifier" "custom_identifier" {
  name       = "CustomPIIIdentifier"
  description = "Custom data identifier for PII"

  regex  = "(John Doe|Jane Smith|123 Main St|456 Oak St|Cityville|Townsville|State|1234-5678-9012-3456|9876-5432-1098-7654)"

}

