## README

### Project Overview
This project uses Terraform to set up and manage various AWS resources, including S3 for storage, CloudFront for content distribution, Route 53 for DNS management, and ACM for SSL/TLS certificates. The setup facilitates a robust and scalable cloud infrastructure, ideal for hosting and distributing web content efficiently.

### Prerequisites
- Terraform (version 1.5.7 or higher)
- AWS Account and AWS CLI configured with appropriate permissions
- Basic knowledge of AWS services and Terraform

### Setup Instructions
1. **Clone the Repository**: Download or clone the Terraform configuration files to your local system.
2. **Install Terraform**: Ensure Terraform (version 1.5.7 or higher) is installed on your machine.
3. **Configure AWS CLI**: Set up your AWS CLI with credentials that have necessary permissions for creating and managing the AWS resources.
4. **Configure Terraform Backend**:
   - Open the `provider.tf` file and locate the Terraform backend configuration section.
   - Replace the `bucket`, `key`, and `region` values with your preferred settings for storing the Terraform state in an S3 bucket.
   - Ensure that the specified S3 bucket exists in your AWS account.

### Usage Guide
1. **Initialize Terraform**:
   Run `terraform init` to initialize the working directory containing Terraform configurations.

2. **Review Configurations**:
   - `provider.tf`: Sets up the AWS provider and backend for Terraform state.
   - `variable.tf`: Defines necessary variables (e.g., AWS region, bucket name).
   - `terraform.tfvars`: Contains the values for the defined variables.
   - `s3.tf`: Configures the S3 bucket for storage.
   - `cloudfront.tf`: Sets up CloudFront distribution linked to the S3 bucket.
   - `route53.tf`: Manages DNS settings and ACM certificate for the domain.
   - `output.tf`: Outputs useful information post-deployment.

3. **Apply Configurations**:
   - Run `terraform plan` to preview the changes Terraform will make.
   - Execute `terraform apply` to apply the configurations and set up the infrastructure.

4. **Verify Deployment**:
   - Use the outputs from `output.tf` to verify resource configurations.
   - Check the AWS Management Console to confirm the resources are set up correctly.

### Additional Notes
- Ensure to review and modify the `terraform.tfvars` file according to your specific requirements (e.g., domain name, region).
- Regularly update Terraform and AWS CLI to their latest versions for improved security and features.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.26.0 |
| <a name="provider_aws.acm_certificate"></a> [aws.acm\_certificate](#provider\_aws.acm\_certificate) | 5.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/acm_certificate) | resource |
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.oai](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_route53_record.certificate_validation](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/route53_record) | resource |
| [aws_route53_record.websiteurl](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/route53_record) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.bucket_ownership](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_website_configuration.website_configuration](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_object.object](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/resources/s3_object) | resource |
| [aws_iam_policy_document.bucket_policy_document](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.public_zone_id](https://registry.terraform.io/providers/hashicorp/aws/5.26.0/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the AWS S3 bucket you want to create. | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The main domain name for which an SSL/TLS certificate will be requested. The certificate will cover this domain and potentially its subdomains. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources will be created. Specify the availability\_zones variable if this region differs from the default. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | Output the Amazon Resource Name (ARN) of the AWS S3 bucket. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Output the unique ID of the AWS S3 bucket. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | Output the regional domain name of the AWS S3 bucket. |
| <a name="output_cloudfront_distribution_url"></a> [cloudfront\_distribution\_url](#output\_cloudfront\_distribution\_url) | Output the URL of the AWS CloudFront distribution associated with the S3 bucket. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
