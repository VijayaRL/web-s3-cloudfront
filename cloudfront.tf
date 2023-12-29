# Define local variable for the AWS CloudFront origin ID.
locals {
  s3_origin_id = "${var.bucket_name}-origin" # Unique identifier for the S3 origin
}

# Create an AWS CloudFront origin access identity (OAI) for the distribution.
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${var.domain_name}" # Description for the OAI
}

# Create an AWS CloudFront distribution associated with the S3 bucket.
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name # Domain name of the S3 bucket
    origin_id   = local.s3_origin_id                               # Unique identifier for this origin in the distribution

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true              # Enable the CloudFront distribution
  default_root_object = "index.html"      # Set the default root object
  aliases             = [var.domain_name] # Map the distribution to the specified domain name

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]    # Allowed HTTP methods
    cached_methods   = ["GET", "HEAD"]    # HTTP methods to cache
    target_origin_id = local.s3_origin_id # Specify the target S3 origin

    forwarded_values {
      query_string = false # Do not forward query strings

      cookies {
        forward = "none" # Do not forward cookies
      }
    }

    viewer_protocol_policy = "redirect-to-https" # Redirect to HTTPS for viewer connections
    min_ttl                = 0                   # Minimum Time To Live (TTL) in seconds
    default_ttl            = 3600                # Default TTL in seconds
    max_ttl                = 86400               # Maximum TTL in seconds
  }

  price_class = "PriceClass_All" # AWS CloudFront price class

  restrictions {
    geo_restriction {
      restriction_type = "none" # No geographic restrictions
    }
  }

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.certificate.arn # ARN of the ACM certificate
    cloudfront_default_certificate = false                               # Not using the CloudFront default certificate
    minimum_protocol_version       = "TLSv1.2_2021"                      # Minimum TLS protocol version
    ssl_support_method             = "sni-only"                          # SSL support method
  }
}
