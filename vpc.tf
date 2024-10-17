resource "aws_vpc" "k8s-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "k8s-subnet-1" {
  vpc_id            = aws_vpc.k8s-vpc.id
  cidr_block        = var.subnet_1_cidr_block
  availability_zone = var.avail_zone
  #map_public_ip_on_launch = "false"
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

resource "aws_subnet" "k8s-subnet-2" {
  vpc_id            = aws_vpc.k8s-vpc.id
  cidr_block        = var.subnet_2_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-2"
  }
}

resource "aws_internet_gateway" "k8s-igw" {
  vpc_id = aws_vpc.k8s-vpc.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.k8s-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s-igw.id
  }
  tags = {
    Name = "${var.env_prefix}-main-rtb"
  }
}
