output "s3_bucket_name" {
  description = "Name of the private S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "s3_bucket_arn" {
  description = "ARN of the private S3 bucket"
  value       = aws_s3_bucket.website.arn
}

output "s3_bucket_region" {
  description = "AWS region of the bucket"
  value       = aws_s3_bucket.website.region
}
