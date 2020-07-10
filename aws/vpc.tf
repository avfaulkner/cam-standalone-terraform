# VPC
resource "aws_vpc" "cam" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "cam-"+var.owner
  }
}

resource "aws_route_table" "cam-rt" {
  vpc_id = aws_vpc.cam.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-public"
  }
}

resource "aws_route_table" "cam-rt-private" {
  vpc_id = aws_vpc.cam.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "rt-private"
  }
}


resource "aws_subnet" "subnet-public" {
  cidr_block = "10.0.10.0/24"
  vpc_id = aws_vpc.cam.id

  tags = {
    Name = "cam-public"
  }
}

resource "aws_subnet" "subnet-private" {
  cidr_block = "10.0.11.0/24"
  vpc_id = aws_vpc.cam.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.cam.id

  tags = {
    Name = "cam-igw"
  }
}

resource "aws_eip" "eip-nat" {
  vpc = true

  tags = {
    Name = "cam-eip-nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip-nat.id
  subnet_id = aws_subnet.subnet-private.id
}