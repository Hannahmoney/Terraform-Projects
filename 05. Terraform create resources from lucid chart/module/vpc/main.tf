# STAGE 1
# ----------------------------------------------------------------------------------------

# Fetch available availability zones
data "aws_availability_zones" "availablezones" {
  state = "available"
}

# 1 VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "thevpc"
  }
}

# 2 Public Subnet A
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block       = var.public_subnet_a_cidr
  availability_zone = data.aws_availability_zones.availablezones.names[0]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "publicsubneta"
  }
}

# 3 Public Subnet B
resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block       = var.public_subnet_b_cidr
  availability_zone = data.aws_availability_zones.availablezones.names[1]
  map_public_ip_on_launch = true
  
  tags = {
    Name = "thepublicsubnetb"
  }
}

# 4 Private Subnet A
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block       = var.private_subnet_a_cidr
  availability_zone = data.aws_availability_zones.availablezones.names[0]
  
  tags = {
    Name = "theprivatesubneta"
  }
}

# 5 Private Subnet B
resource "aws_subnet" "private_subnet_b" {     
  vpc_id            = aws_vpc.vpc.id
  cidr_block       = var.private_subnet_b_cidr
  availability_zone = data.aws_availability_zones.availablezones.names[1] 
  tags = {
    Name = "theprivatesubnetb"
  }
}

# 6 Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "theigw"
  }
}

# 7 Public route table
resource "aws_route_table" "publicrt" { 
    vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }  

    tags = {
        Name = "thepublic_rt"
    }
}

# 8 Associate public subnet A with public route table
resource "aws_route_table_association" "thepublicrt_assoc_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.publicrt.id
}

# 9 Associate public subnet B with public route table
resource "aws_route_table_association" "thepublicrt_assoc_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.publicrt.id
}

# 10 NAT EIP
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  
  tags = {
    Name = "thenat_eip"
  }
}   


# 11 NAT gateway in public subnet A
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id
  
  tags = {
    Name = "thenat_gw"
  }
}

# 12 Private route table
resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
    } 

  tags = {
    Name = "theprivatert"
  }
}

# 13 Associate private subnet A with private route table
resource "aws_route_table_association" "privatert_assoc_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.privatert.id
}

# 14 Associate private subnet B with private route table
resource "aws_route_table_association" "privatert_assoc_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.privatert.id
}


