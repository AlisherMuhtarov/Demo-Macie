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
  regex                  = "address"
  description            = "regex for address"
  maximum_match_distance = 7

  depends_on = [aws_macie2_account.local]
}

resource "aws_macie2_custom_data_identifier" "name" {
  name                   = "name_identifier"
  regex                  = "Name"
  description            = "regex for name"
  maximum_match_distance = 4

  depends_on = [aws_macie2_account.local]
}

resource "aws_macie2_custom_data_identifier" "ccn" {
  name                   = "ccn_identifier"
  regex                  = "Card"
  description            = "regex for card"
  maximum_match_distance = 4

  depends_on = [aws_macie2_account.local]
}