resource "aws_s3_bucket" "testbucket" {
  bucket = "${var.env}-${var.s3_bucket_name}-${count.index + 1}"
  count = var.s3_bucket_count
  tags = {
    Name = "${var.env}-${var.s3_bucket_name}-${count.index + 1}"
    Environment = var.env
  }
}