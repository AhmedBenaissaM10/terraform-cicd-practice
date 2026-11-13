terraform {
  backend "s3" {
    bucket       = "my-remote-backend-terraform-bucket"
    key          = "dev/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }
}

# resource "aws_s3_bucket" "backend" {
#   bucket = "my-remote-backend-terraform-bucket"

#   tags = {
#     Name = "Remote_Backend"
#   }
# }
# resource "aws_s3_bucket_versioning" "backend_versioning" {
#   bucket = aws_s3_bucket.backend.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }
# resource "aws_s3_bucket_server_side_encryption_configuration" "backend_encryption" {
#   bucket = aws_s3_bucket.backend.id
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }
# resource "aws_s3_bucket_public_access_block" "backend_public_access_block" {
#   bucket                  = aws_s3_bucket.backend.id
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }
