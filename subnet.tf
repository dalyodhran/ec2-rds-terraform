resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name = "rds subnet group"
    subnet_ids = [
        aws_subnet.private-subnet-1.id,
        aws_subnet.private-subnet-2.id
    ]
}
