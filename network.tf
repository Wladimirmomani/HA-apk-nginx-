
resource "aws_vpc" "main" {
  cidr_block = var.VpcCidr

  tags = {
    Name = var.VpcName
  }
}

resource "aws_subnet" "public" {
  count  = length(data.aws_availability_zones.available.names)
  vpc_id  = aws_vpc.main.id
  cidr_block = "10.0.1${count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "${var.PublicSubnetName}-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(data.aws_availability_zones.available.names)
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.PrivateSubnetName}-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "ip-ngw" {
   tags = {
    Name = "eip-PA"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ip-ngw.id
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = var.NGWName
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.CidrInternet
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.PublicRTName
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.CidrInternet
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = var.PrivateRTName
  }
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "eks_node_group_sg" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port = 0
    to_port  = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port  = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port  = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port  = 443
    to_port  = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
