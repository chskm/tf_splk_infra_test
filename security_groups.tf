# Splunk Infra Security Groups - allowing ingress from anywhere : 80/443 over TCP
resource "aws_security_group" "lb-sg" {
  provider    = aws
  name        = "lb-sg"
  description = "Allow 443 and traffic to Splunk SG"
  vpc_id      = aws_vpc.vpc_splk.id
  ingress {
    description = "Allow 443 from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.rt_igw]
  }
  ingress {
    description = "Allow 80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.rt_igw]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.rt_igw]
  }
}

# Create SG for allowing TCP : 8000/8089/22 from your IP to us-east-1
resource "aws_security_group" "splk-sg" {
  provider    = aws
  name        = "splk-sg"
  description = "Allow TCP/8000 & TCP/22"
  vpc_id      = aws_vpc.vpc_splk.id
  ingress {
    description = "Allow 22 from our public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external_ip]
  }
  ingress {
    description     = "Allow 8000 from our public IP"
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.rt_igw]
  }
}