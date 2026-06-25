variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "Shubh-test-my-app-bucket-d"
}

variable "env" {
  description = "Environment for the EC2 instance"
  type        = string
}

variable "s3_bucket_count" {
  description = "Number of S3 buckets to create"
  type        = number
}