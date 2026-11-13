name: Terraform CI/CD
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main


jobs:
    terraform:
        name: Terraform
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v4
            - name: Configure AWS credentials
              uses: aws-actions/configure-aws-credentials@v4
              with:
                aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
                aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
                aws-region: ${{ env.AWS_REGION }}

            - name: Verify AWS Identity
              run: aws sts get-caller-identity

            - name: Setup Terraform
              uses: hashicorp/setup-terraform@v3
              with:
                terraform_version: "~> 1.10"
            - name: Format check
              run: terraform fmt -check -recursive
            - name: Init
              run: terraform init -backend=false -input=false
            - name: Validate
              run: terraform validate
