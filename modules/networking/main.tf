resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "InternetGateway_Terraform"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "PublicRouteTable_Terraform"
  }
}
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = var.public_subnet_id
  route_table_id = aws_route_table.public_rt.id
}

