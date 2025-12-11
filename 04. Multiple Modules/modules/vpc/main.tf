# This module contains 5 resources. 
#1 First, create VPC
resource "aws_vpc" "thevpc" {
    cidr_block = var.thevpc_cidr
    tags = {
        Name = "thevpc"
    }
}

#2 Create the public subnet
resource "aws_subnet" "thepublicsubnet" {
    vpc_id            = aws_vpc.thevpc.id
    cidr_block       = var.thepublicsubnet_cidr
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "thepublic_subnet"
    }
}

#3 Create an internet gateway
resource "aws_internet_gateway" "theigw" {
    vpc_id = aws_vpc.thevpc.id

    tags = {
        Name = "theigw"
    }
}

#4 Create a route table
resource "aws_route_table" "thepublic_rt" { 
    vpc_id = aws_vpc.thevpc.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.theigw.id
    }  

    tags = {
        Name = "thepublic_rt"
    }
}

#5 Associate the route table with the public subnet
resource "aws_route_table_association" "thepublic_rt_assoc" {
    subnet_id      = aws_subnet.thepublicsubnet.id
    route_table_id = aws_route_table.thepublic_rt.id
}

