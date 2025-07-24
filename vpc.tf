resource "aws_vpc" "terraform" {
    cidr_block = "10.0.0.0/16"
     tags = {
    Name = "main"
  }
}        

#IG 
resource "aws_internet_gateway" "internetgateway" {
    vpc_id = aws_vpc.terraform.id  
    tags = {
    Name = "main-igw"
  }
}

#Public 
resource "aws_subnet" "Public" {
    vpc_id = aws_vpc.terraform.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true  
    tags = {
    Name = "public"
  }
}

#private
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.terraform.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
    Name = "private"
  }
}

#RouteTable
resource "aws_route_table" "routeme" {
    vpc_id = aws_vpc.terraform.id
  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internetgateway.id
  }
   tags = {
    Name = "rt"
  }
}

#Assosiate RT with public
resource "aws_route_table_association" "asso" {
    subnet_id = aws_subnet.Public.id
    route_table_id = aws_route_table.routeme.id
  
}