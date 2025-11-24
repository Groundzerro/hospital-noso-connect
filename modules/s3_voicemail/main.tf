resource "aws_s3_bucket" "voicemail" {
  bucket = "${var.name_prefix}-voicemail-audio"
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "voicemail" {
  bucket = aws_s3_bucket.voicemail.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "voicemail" {
  bucket = aws_s3_bucket.voicemail.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "voicemail" {
  bucket                  = aws_s3_bucket.voicemail.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
