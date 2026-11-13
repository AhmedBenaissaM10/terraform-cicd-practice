variable "key_name" {
  description = "The name of the key pair to use for the EC2 instances"
  type        = string
}
variable "subnet_public_id" {
  description = "The public subnet to launch the EC2 instance in"
  type        = string
}

variable "public_sg_id" {
  description = "The security group for the public EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
}
