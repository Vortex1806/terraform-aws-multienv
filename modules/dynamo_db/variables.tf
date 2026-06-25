variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "Shubh-test-my-app-table-d"
}

variable "env" {
  description = "Environment for the EC2 instance"
  type        = string
}

variable "dynamodb_table_count" {
  description = "Number of DynamoDB tables to create"
  type        = number
}