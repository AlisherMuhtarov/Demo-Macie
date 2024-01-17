variable "enable_macie" {
  description = "Set to true to enable AWS Macie, false to disable."
  type        = bool
  default     = false  # Set to true by default, adjust as needed
}