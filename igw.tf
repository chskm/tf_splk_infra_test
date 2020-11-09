# Internet Gateway for Splunk Infra
resource "aws_internet_gateway" "igw" {
  provider = aws
  vpc_id   = aws_vpc.vpc_splk.id
}