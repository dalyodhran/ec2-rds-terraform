resource "aws_route_table" "nat-gateway" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nat-gateway.id
  }
}


resource "aws_route_table_association" "nat-gateway" {
  subnet_id = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.nat-gateway.id
}

resource "aws_route_table" "instance" {
  vpc_id = aws_vpc.my-vpc.id
    route {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat-gateway.id
    }
}

resource "aws_route_table_association" "instance-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.instance.id
}

resource "aws_route_table_association" "instance-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.instance.id
}