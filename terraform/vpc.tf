resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "VPC-${local.timestamp_sanitized}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

#Use Data Source to get all availability zones in the region
data "aws_availability_zones" "zones" {
  state = "available"
}

#Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.zones.names[count.index]
  tags = {
    Name = "Public Subnet-${count.index + 1}"
  }
}

#Create Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.public_cidr_block
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

#Associate Public Subnets to Route Table
resource "aws_route_table_association" "public_route_table_association" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

#Create Private Subnets
resource "aws_subnet" "private_subnets" {
  count                   = var.private_subnet_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + var.public_subnet_count + 1)
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.zones.names[count.index]
  tags = {
    Name = "Private Subnet-${count.index + 1}"
  }
}

#Create Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
}

#Associate Private Subnets to Route Table
resource "aws_route_table_association" "private_route_table_association" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
