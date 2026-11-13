variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for the subnets"
}
