resource "aws_vpc" "main" {

  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = merge(var.common_tags, var.vpc_tags)

}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, var.igw_tags)
}

resource "aws_subnet" "public_subnet" {

  count             = length(var.public_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr[count.index]
  availability_zone = var.azones[count.index]
  tags = merge(var.common_tags,
    {
      Name = var.public_subnet_names[count.index]
    }
  )

}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.azones[count.index]
  tags = merge(var.common_tags,
    {
      Name = var.private_subnet_names[count.index]
    }
  )

}

resource "aws_subnet" "database_subnet" {

  count             = length(var.database_subnet_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = var.azones[count.index]
  tags = merge(var.common_tags,
    {
      Name = var.database_subnet_names[count.index]
    }
  )

}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, var.public_route_table_tags)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}
# associate public route tables with public subnets
# public-route-table ---> public-subnet-1a
# public-route-table ---> public-subnet-1b
resource "aws_route_table_association" "public_rt_assoc" {
  count = length(var.public_subnet_cidr)
  subnet_id = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, var.private_route_table_tags)

}
resource "aws_route_table_association" "private_rt_assoc" {
  count = length(var.private_subnet_cidr)
  subnet_id = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}



resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.common_tags, var.database_route_table_tags)

}
resource "aws_route_table_association" "database_rt_assoc" {
  count = length(var.database_subnet_cidr)
  subnet_id = element(aws_subnet.database_subnet[*].id, count.index)
  route_table_id = aws_route_table.database_route_table.id
}




