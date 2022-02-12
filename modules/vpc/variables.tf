variable "vpc_cidr_block" {
    type = string
    description= "VPC CIDR block"
    default = "10.90.77.0/24"
  
}

variable "vpc_name" {
    type = string
    description = "Name of the VPC"
    default = "dev"
  
}

variable "cidr_public_subnet_az1" {
    type = string
    description = "CIDR for public subnet 1"
    default = "10.90.77.0/26"
  
}
variable "cidr_public_subnet_az2" {
    type = string
    description = "CIDR for public subnet az 2"
    default = "10.90.77.64/26"
  
}

variable "cidr_private_subnet_az1" {
    type = string
    description = "CIDR for private subnet az 1"
    default = "10.90.77.128/26"
  
}
variable "cidr_private_subnet_az2" {
    type = string
    description = "CIDR for private subnet az 2"
    default = "10.90.77.192/26"
  
}

