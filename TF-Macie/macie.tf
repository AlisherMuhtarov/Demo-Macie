resource "aws_macie2_account" "local" {
    count  = var.enable_macie ? 1 : 0
    status = "ENABLED"
}

resource "aws_macie2_classification_job" "test" {
  job_type = "ONE_TIME"
  name     = "PII-Detection-${timestamp()}"
  initial_run = true
  sampling_percentage = 100
  s3_job_definition {
    bucket_definitions {
      account_id = "${data.aws_caller_identity.current.account_id}"
      buckets    = [aws_s3_bucket.demo.bucket]
    }
  }
  depends_on = [aws_macie2_account.local]
}

resource "aws_macie2_custom_data_identifier" "address" {
  name                   = "address_identifier"
  regex                  = <<EOT
    ^\d+\s[A-Za-z\s]+,\s[A-Za-z\s]+,\s[A-Za-z]+$
  EOT
  description            = "Demo"
  maximum_match_distance = 7

  depends_on = [aws_macie2_account.local]
}

resource "aws_macie2_custom_data_identifier" "name" {
  name                   = "name_identifier"
  regex                  = <<EOT
    ^[A-Za-z]+\s[A-Za-z]+$
  EOT
  description            = "Demo"
  maximum_match_distance = 4

  depends_on = [aws_macie2_account.local]
}

resource "aws_macie2_custom_data_identifier" "ccn" {
  name                   = "ccn_identifier"
  regex                  = <<EOT
    ^\d{4}-\d{4}-\d{4}-\d{4}$
EOT
  description            = "Demo"
  maximum_match_distance = 6

  depends_on = [aws_macie2_account.local]
}