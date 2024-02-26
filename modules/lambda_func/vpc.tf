resource "aws_vpc" "lambda_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "test-lambda-vpc"
  }
}

resource "aws_subnet" "lambda_pvt_subnet" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.lambda_vpc.id
  availability_zone = "us-east-1a"

  tags = {
    Name = "test-lambda-subnet"
  }
}