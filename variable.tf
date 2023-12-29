# Variable definition for the AWS region.
variable "region" {
  description = "The AWS region where resources will be created. Specify the availability_zones variable if this region differs from the default."
  type        = string
}

# Variable definition for the primary domain name used for SSL/TLS certificate.
variable "domain_name" {
  description = "The main domain name for which an SSL/TLS certificate will be requested. The certificate will cover this domain and potentially its subdomains."
  type        = string
}

# Variable definition for the name of an AWS S3 bucket.
variable "bucket_name" {
  description = "The name of the AWS S3 bucket you want to create."
  type        = string
}
