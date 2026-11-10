locals {
  s3_bucket_name = "${var.project_name}-${data.aws_caller_identity.current.account_id}"
}
resource "aws_s3_bucket" "website" {
  bucket        = local.s3_bucket_name
  force_destroy = false

  tags = {
    Name        = local.s3_bucket_name
    Environment = "Production"
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
# 2. Block all public access
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
# 3. Enable bucket versioning
resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id

  versioning_configuration {
    status = "Enabled"
  }
}
# 4. Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 5. Enforce bucket ownership
resource "aws_s3_bucket_ownership_controls" "website" {
  bucket = aws_s3_bucket.website.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
# 6. Upload website index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "${path.module}/website/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/website/index.html")

  depends_on = [
    aws_s3_bucket_public_access_block.website,
    aws_s3_bucket_ownership_controls.website,
    aws_s3_bucket_server_side_encryption_configuration.website
  ]
}
