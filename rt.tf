# Routing Table for Splunk Infra
resource "aws_route_table" "internet_route" {
  provider = aws
  vpc_id   = aws_vpc.vpc_splk.id
  route {
    cidr_block = var.rt_igw
    gateway_id = aws_internet_gateway.igw.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "Splunk-Infra-RT"
  }
}

# Overwrite default route table of Splunk Infra VPC with our RT
resource "aws_main_route_table_association" "splk-default-rt" {
  provider       = aws
  vpc_id         = aws_vpc.vpc_splk.id
  route_table_id = aws_route_table.internet_route.id
}
