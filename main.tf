

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zones = data.aws_availability_zones.available.names
}

module "networking" {
  source           = "./modules/networking"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source           = "./modules/ec2"
  key_name         = var.key_name
  subnet_public_id = module.vpc.public_subnet_id
  public_sg_id     = module.security_group.public_sg_id
  instance_type    = var.instance_type
}
