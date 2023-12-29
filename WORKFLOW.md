# GitHub Actions Workflow: Terraform Setup

## Overview

This GitHub Actions workflow, named "Terraform Setup," automates the process of setting up and managing AWS resources using Terraform. It provides flexibility for creating or destroying the infrastructure based on user input, making it a versatile tool for managing your cloud resources.

## Workflow Triggers

The workflow is triggered manually by a user, allowing you to initiate the Terraform setup process when needed. It provides an input parameter called `destroy`, which is a boolean value used to determine whether to create or destroy the Terraform stack. The `destroy` parameter is optional, and its default value is `false`.

## Permissions

This workflow requires the following permissions:

- **contents: read**: This permission is required for reading the contents of the repository. It allows the workflow to access and checkout the Terraform configuration files.

## Workflow Structure

The workflow consists of a single job named "Setup" that runs on an Ubuntu-latest runner. The job is responsible for setting up the Terraform environment, initializing Terraform, validating configurations, creating a Terraform plan, and applying or destroying Terraform resources based on the `destroy` input parameter.

### Job Steps

1. **Checkout the Repository**:
   - Action: `actions/checkout@v3`
   - Purpose: This step checks out the repository's source code, making it accessible for subsequent steps.

2. **Configure AWS Credentials**:
   - Action: `aws-actions/configure-aws-credentials@v3`
   - Purpose: This step configures AWS credentials for authentication, allowing Terraform to interact with your AWS account. It uses the AWS access key ID, AWS secret access key, and AWS region stored in GitHub secrets.

3. **Install Terraform**:
   - Action: `hashicorp/setup-terraform@v2`
   - Purpose: This step installs the Terraform CLI on the runner, ensuring that the required Terraform version is available for use.

4. **Initialize Terraform**:
   - Purpose: This step initializes the Terraform working directory by running `terraform init`. It prepares Terraform to use the specified backend and providers.

5. **Validate Terraform Configuration**:
   - Purpose: This step validates the Terraform configurations by running `terraform validate`. It checks the syntax and structure of the configuration files.

6. **Create Terraform Plan**:
   - Purpose: This step creates a Terraform execution plan by running `terraform plan` and saves it as `out.plan`. The plan describes the changes Terraform will make to your infrastructure.

7. **Apply Terraform Changes (if destroy input is false)**:
   - Condition: This step is executed only if the `destroy` input parameter is `false`.
   - Purpose: If the `destroy` input is set to `false`, this step applies the Terraform changes by running `terraform apply out.plan`. It deploys or updates the infrastructure based on the execution plan.

8. **Destroy Terraform Resources (if destroy input is true)**:
   - Condition: This step is executed only if the `destroy` input parameter is `true`.
   - Purpose: If the `destroy` input is set to `true`, this step destroys Terraform-managed resources by running `terraform destroy --auto-approve`. It removes the infrastructure as defined in the Terraform configurations.

## Usage Instructions

To use this GitHub Actions workflow for your Terraform project, follow these steps:

1. **Manual Trigger**:
   - Manually trigger the workflow in the GitHub Actions tab.
   - Optionally, provide the `destroy` input parameter with a value of `true` to destroy the stack, or leave it unset (default `false`) to create the stack.

2. **Review Output**:
   - Review the output of the workflow to monitor the progress of Terraform operations.
   - Check for any errors or warnings during validation and execution.

3. **Confirm Infrastructure**:
   - After the workflow completes successfully, verify the infrastructure on the AWS Management Console or by using AWS CLI commands.

4. **Cleanup (if necessary)**:
   - If you used the `destroy` input to remove resources, confirm that the resources are deleted as expected.

## Additional Notes

- Customize the Terraform configurations in your repository to match your infrastructure requirements.
- Ensure that you have set up AWS credentials and stored them securely in GitHub secrets.
- Regularly update Terraform and AWS CLI to their latest versions for improved security and features.
- Consider integrating this workflow with your development and deployment processes to automate infrastructure management.
