terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.35.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-north-1"
}

# aws create vpc

resource "aws_vpc" "mr-vpc" {
  cidr_block       = "10.0.0.0/16"
  //instance_tenancy = "default"

  tags = {
    Name = "mr-vpc"
  }
}

#private subnet

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.mr-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private-subnet"
  }
}

#public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.mr-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public-subnet"
  }
}

#internet gateway

resource "aws_internet_gateway" "mr-igw" {
  vpc_id = aws_vpc.mr-vpc.id

  tags = {
    Name = "mr-igw"
  }
}

#route table
resource "aws_route_table" "mr-rt" {
  vpc_id = aws_vpc.mr-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mr-igw.id
  }

  tags = {
    Name = "mr-rt"
  }
}

resource "aws_route_table_association" "public-sub" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.mr-rt.id
}

resource "aws_instance" "mrServer" {
    ami = "ami-04c54313c5ae6bbcb"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.public-subnet.id


    tags = {
        Name = "SimpleServer"
    }
}