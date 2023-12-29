# Create an AWS S3 bucket with the specified bucket name.
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

# Configure AWS S3 bucket ownership controls for BucketOwnerPreferred.
resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Set AWS S3 bucket access control to private.
resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]
  bucket     = aws_s3_bucket.bucket.id
  acl        = "private"
}

# Configure AWS S3 bucket as a static website.
resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Define an IAM policy document allowing CloudFront access to S3 objects.
data "aws_iam_policy_document" "bucket_policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = [aws_s3_bucket.bucket.arn, "${aws_s3_bucket.bucket.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}

# Attach the IAM policy document to the S3 bucket.
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_document.json
}

# Upload HTML files from the 'website/' directory to the S3 bucket.
resource "aws_s3_object" "object" {
  for_each     = fileset("website/", "**/*.html")
  bucket       = aws_s3_bucket.bucket.id
  key          = each.value
  source       = "website/${each.value}"
  etag         = filemd5("website/${each.value}")
  content_type = "text/html"

  depends_on = [
    aws_s3_bucket.bucket
  ]
}
