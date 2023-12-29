# Output the regional domain name of the AWS S3 bucket.
output "bucket_regional_domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}

# Output the unique ID of the AWS S3 bucket.
output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

# Output the Amazon Resource Name (ARN) of the AWS S3 bucket.
output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

# Output the URL of the AWS CloudFront distribution associated with the S3 bucket.
output "cloudfront_distribution_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
