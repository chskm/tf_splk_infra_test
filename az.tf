# Splunk Infra Availability Zones
# Get all available AZ's in VPC for Splunk infra
data "aws_availability_zones" "az" {
  provider = aws
  state    = "available"
}