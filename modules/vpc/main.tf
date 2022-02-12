terraform {

  required_version = ">= 0.12"
  
}

data "aws_availability_zones" "available" {
  state = "available"

}

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }

}

resource "aws_subnet" "public-subnet-az1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_public_subnet_az1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-1-${var.vpc_name}"
  }

}

resource "aws_subnet" "public-subnet-az2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_public_subnet_az2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-2-${var.vpc_name}"
  }


}

resource "aws_subnet" "private-subnet-az1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_private_subnet_az1
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = "false"
  tags = {
    Name = "priv-1-${var.vpc_name}"
  }

}

resource "aws_subnet" "private-subnet-az2" {

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.cidr_private_subnet_az2
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = "false"
  tags = {
    Name = "priv-2-${var.vpc_name}"
  }

}

resource "aws_route" "public-route" {

  depends_on             = [aws_internet_gateway.igw]
  route_table_id         = aws_route_table.public-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "route-pub-table-${var.vpc_name}"
  }
}

resource "aws_route_table_association" "public-subnet-route-table-association-01" {
  subnet_id      = aws_subnet.public-subnet-az1.id
  route_table_id = aws_route_table.public-route-table.id

}

resource "aws_route_table_association" "public-subnet-route-table-association-02" {
  subnet_id      = aws_subnet.public-subnet-az2.id
  route_table_id = aws_route_table.public-route-table.id

}

resource "aws_route_table" "private-route-table-01" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "route-priv-table-01${var.vpc_name}"
  }
}

resource "aws_route_table" "private-route-table-02" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "route-priv-table-02-${var.vpc_name}"
  }
  
}

resource "aws_route_table_association" "private-subnet-route-table-association-01" {
  subnet_id      = aws_subnet.private-subnet-az1.id
  route_table_id = aws_route_table.private-route-table-01.id

}

resource "aws_route_table_association" "private-subnet-route-table-association-02" {
  subnet_id      = aws_subnet.private-subnet-az2.id
  route_table_id = aws_route_table.private-route-table-02.id

}

resource "aws_nat_gateway" "nat-gateway-01" {
  allocation_id = aws_eip.eip-for-natgateway-01.allocation_id
  subnet_id     = aws_subnet.public-subnet-az1.id
  tags = {
    Name = "nat-gateway-01-${var.vpc_name}"
  }

}

resource "aws_nat_gateway" "nat-gateway-02" {
  allocation_id = aws_eip.eip-for-natgateway-02.allocation_id
  subnet_id = aws_subnet.private-subnet-az2.id
  tags = {
    Name = "nat-gateway-02-${var.vpc_name}"
  }

  
}

resource "aws_eip" "eip-for-natgateway-01" {
  vpc = true

}
resource "aws_eip" "eip-for-natgateway-02" {
  vpc = true

}

resource "aws_route" "nat-route-priv-01" {

  route_table_id         = aws_route_table.private-route-table-01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gateway-01.id
}

resource "aws_route" "nat-route-priv-02" {
  route_table_id = aws_route_table.private-route-table-02.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat-gateway-02.id
}
