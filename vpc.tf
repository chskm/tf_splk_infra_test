# Create VPC for Splunk Infra
resource "aws_vpc" "vpc_splk" {
  provider             = aws
  cidr_block           = var.vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "splunk-infra-vpc-us-east1"
  }
}