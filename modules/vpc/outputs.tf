output "vpc_id" {
    value = aws_vpc.main_vpc.id
    description = "VPC ID"
}

output "private_subnet_az1" {
    value = aws_subnet.private-subnet-az1.id
    description = "Private subnet id for az1"
  
}

output "private_subnet_az2" {
    value = aws_subnet.private-subnet-az2.id
    description = "Private subnet id for az2"
  
}

output "public_subnet_az1" {
    value = aws_subnet.public-subnet-az1.id
    description = "Public subnet id for az1"
  
}

output "public_subnet_az2" {
    value = aws_subnet.public-subnet-az2.id
    description = "Public subnet id for az2"
  
}

output "vpc_cidr" {
     value = aws_vpc.main_vpc.cidr_block
     description = "VPC CIDR"
  
}