# Splunk infra subnets
resource "aws_subnet" "subnet_1" {
  provider                = aws
  availability_zone       = element(data.aws_availability_zones.az.names, 0)
  vpc_id                  = aws_vpc.vpc_splk.id
  cidr_block              = var.subnet_1
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-az-a"
  }
}

resource "aws_subnet" "subnet_2" {
  provider                = aws
  availability_zone       = element(data.aws_availability_zones.az.names, 1)
  vpc_id                  = aws_vpc.vpc_splk.id
  cidr_block              = var.subnet_2
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-az-b"
  }
}

#locals {
#  subs = concat([aws_subnet.subnet_1.id], [aws_subnet.subnet_2.id])
#}