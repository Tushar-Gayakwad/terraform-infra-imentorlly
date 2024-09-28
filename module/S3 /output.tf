output "id" {
  value = {
    name = aws_s3_bucket.s3_default.bucket
  }
  description = "The ID of the s3 bucket."
}
