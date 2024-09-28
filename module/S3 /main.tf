resource "aws_s3_bucket" "s3_default" {
  bucket              = var.s3_name
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags_name
}

resource "aws_s3_bucket_policy" "s3_default" {
  bucket = var.bucket_id
  policy = var.aws_iam_policy_document

  depends_on = [
    aws_s3_bucket.s3_default
  ]
}
resource "aws_s3_bucket_versioning" "example" {
  bucket                = var.bucket_id
  versioning_configuration {
    status     = var.versioning_status
  }
}
resource "aws_s3_bucket_website_configuration" "this" {
  bucket                = var.bucket_id
  dynamic "index_document" {
    for_each = try([var.website["index_document"]], [])

    content {
      suffix = index_document.value
    }
  }

  dynamic "error_document" {
    for_each = try([var.website["error_document"]], [])

    content {
      key = error_document.value
    }
  }

