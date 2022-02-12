provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["C:\\Users\\Nagarjun\\.aws\\credentials"]
  profile                  = "lamp"
}

module "vpc_config" {
  source                  = "..\\modules\\vpc"
  vpc_cidr_block          = var.vpc_cidr_block
  vpc_name                = var.vpc_name
  cidr_public_subnet_az1  = var.cidr_public_subnet_az1
  cidr_public_subnet_az2  = var.cidr_public_subnet_az2
  cidr_private_subnet_az1 = var.cidr_private_subnet_az1
  cidr_private_subnet_az2 = var.cidr_private_subnet_az2

}