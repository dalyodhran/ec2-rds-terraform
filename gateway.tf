resource "aws_internet_gateway" "nat-gateway" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_nat_gateway" "nat-gateway" {
  subnet_id = aws_subnet.public-subnet.id
  allocation_id = aws_eip.nat_gateway.id
}