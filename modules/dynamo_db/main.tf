resource "aws_dynamodb_table" "my_app_table" {
  name         = "${var.env}-${var.dynamodb_table_name}-${count.index + 1}"
  count       = var.dynamodb_table_count
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "${var.env}-${var.dynamodb_table_name}-${count.index + 1}"
    Environment = var.env
  }
}
