# Declare required Terraform version and providers
terraform {
  required_version = ">=1.5.7"

  # Declare required AWS provider and version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}

# Provider 1 - Default AWS provider configuration for resources
provider "aws" {
  region = var.region # Set the AWS region using a variable
}

# Provider 2 - AWS ACM (Amazon Certificate Manager) provider configuration
# This provider is used specifically for ACM certificate-related resources and is set to us-east-1.
provider "aws" {
  alias  = "acm_certificate"
  region = "us-east-1"
}

# Configure Terraform backend for remote state storage in an S3 bucket
terraform {
  backend "s3" {
    bucket  = "sample-terraform-backend-store" # Specify the S3 bucket for remote state storage
    encrypt = true                             # Enable encryption for the stored state file
    key     = "s3-terraform.tfstate"           # Define the key (path) for the state file in the bucket
    region  = "ap-south-1"                     # Specify the AWS region for the S3 bucket
  }
}
