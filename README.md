# Terraform AWS Infrastructure with GitHub Actions CI/CD

## Overview

This project provisions AWS infrastructure using Terraform and automates infrastructure validation, planning, and deployment using GitHub Actions.

It uses an Amazon S3 remote backend to store Terraform state and supports manual deployment authorization.

## Architecture

The infrastructure includes:

- **VPC** — isolated AWS network.
- **Public subnet** — hosts the EC2 instance.
- **Internet Gateway** — provides internet connectivity.
- **Public route table** — routes internet-bound traffic through the Internet Gateway.
- **Security Group** — controls inbound and outbound traffic.
- **EC2 instance** — deployed inside the public subnet.

## Technologies

- Terraform 1.16.6
- AWS
- Amazon VPC
- Amazon EC2
- Amazon S3
- GitHub Actions
- YAML

## Project Structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml
├── modules/
│   ├── ec2/
│   ├── networking/
│   ├── security-group/
│   └── vpc/
├── backend.tf
├── data.tf
├── main.tf
├── outputs.tf
├── provider.tf
├── variables.tf
└── .gitignore
```

## Remote Backend

Terraform state is stored in an S3 bucket.

```hcl
terraform {
  backend "s3" {
    bucket       = "my-remote-backend-terraform-bucket"
    key          = "dev/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}
```

This allows Terraform state to persist outside the local machine and supports state locking.

## CI/CD Pipeline

The GitHub Actions workflow contains three jobs.

### 1. CI — Continuous Integration

Runs on pushes, pull requests, and manual workflow dispatches.

- Checks Terraform formatting.
- Initializes Terraform without accessing the remote backend.
- Validates the Terraform configuration.

### 2. Plan — Infrastructure Planning

Runs on pushes to `main` and manual workflow dispatches.

- Configures AWS credentials from GitHub Secrets.
- Verifies the AWS identity.
- Initializes the S3 backend.
- Generates a Terraform execution plan.
- Uploads the plan as a workflow artifact.

### 3. Apply — Infrastructure Deployment

Runs only when the workflow is manually triggered from `main` and the `confirm_apply` input is set to `true`.

- Checks out the repository.
- Configures Terraform and AWS credentials.
- Initializes the remote backend.
- Downloads the previously generated plan.
- Applies the saved plan.

## GitHub Secrets

Configure these repository secrets:

| Secret | Description |
|---|---|
| `AWS_ACCESS_KEY_ID` | AWS IAM access key |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM secret access key |

Never commit AWS credentials or Terraform state files to the repository.

## Running Locally

Initialize Terraform:

```bash
terraform init
```

Format the configuration:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

Preview infrastructure changes:

```bash
terraform plan
```

Apply changes:

```bash
terraform apply
```

Destroy the infrastructure when it is no longer needed:

```bash
terraform destroy
```

## Security Considerations

- AWS credentials are stored in GitHub Secrets.
- Terraform state is stored remotely in S3.
- A manual confirmation is required before the deployment job runs.
- Terraform state files and plan files should not be committed to Git.
- Use least-privilege IAM permissions.
- Restrict EC2 security group access to trusted IP addresses.
- Rotate IAM access keys periodically.
- Protect the S3 backend with appropriate access controls and versioning.

## What I Practiced

- Infrastructure as Code with Terraform.
- Terraform modules and reusable infrastructure.
- AWS networking and EC2 provisioning.
- S3 remote state management.
- Terraform formatting and validation.
- GitHub Actions CI/CD workflows.
- AWS authentication in GitHub Actions.
- Automated Terraform planning.
- Manual deployment authorization.
- Applying saved Terraform plans.

## Deployment Verification

The deployment was verified successfully:

- Terraform outputs returned the expected AWS resource IDs.
- SSH connection to the deployed EC2 instance succeeded.
- HTTP response from the instance's local web server succeeded.

## Region

`eu-north-1` — Europe (Stockholm)
