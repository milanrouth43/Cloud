# Base Network Architecture - Insecure Baseline for Analysis
# Security Note: This module contains intentional security gaps for educational analysis
# Students will harden this in Session 2.2

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# AWS VPC Configuration
resource "aws_vpc" "main" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "SecureCourse-VPC"
    Environment = "Lab"
    Session     = "2.1"
  }
}

# Public Subnet (Intentionally broad access for analysis)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.aws_public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true # ⚠️ Security Risk: Auto-assign public IP

  tags = {
    Name = "Public-Subnet"
    Type = "Web Tier"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_private_subnet_cidr
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Private-Subnet"
    Type = "App Tier"
  }
}

# Internet Gateway (Attached but no restrictive routing yet)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Course-IGW"
  }
}

# Route Table (Insecure: All traffic to IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public-RT"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Azure VNet Configuration (Parallel)
resource "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group
  location = var.azure_region
}

resource "azurerm_virtual_network" "vnet" {
  name                = "SecureCourse-VNet"
  address_space       = [var.azure_vnet_cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    Environment = "Lab"
    Session     = "2.1"
  }
}

resource "azurerm_subnet" "public" {
  name                 = "Public-Subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.azure_public_subnet_cidr]
}

resource "azurerm_subnet" "private" {
  name                 = "Private-Subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.azure_private_subnet_cidr]
}
