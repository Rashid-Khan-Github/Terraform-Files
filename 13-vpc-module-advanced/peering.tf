#VPC Peering with default VPC
resource "aws_vpc_peering_connection" "peering_connection" {
  count = var.is_peering_required ? 1 : 0
  peer_vpc_id = aws_vpc.main_vpc.id     # Acceptor VPC (Target which you want to peer with)
  vpc_id = var.requestor_vpc_id         # Requestor VPC (Default VPC in our case)
  auto_accept = true
  tags = merge(
    {
      Name = "VPC Peering between default and ${var.project_name}-VPC"
    },
    var.common_tags
  )
}

# Setting Robo_VPC Route into Default RouteTable and pointing to VPC Peering Connection
resource "aws_route" "default_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id = var.default_route_table_id
  destination_cidr_block = var.cidr_block
  #Since we have set count parameter, it is treated as list, so even if there is a
  #single element you should write it as per list syntax
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection[0].id
}

# Setting default_VPC Route into RoboVPC Public Route Table and pointing to VPC Peering Connection
resource "aws_route" "public_sub_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = var.default_vpc_cidr
  #Since we have set count parameter, it is treated as list, so even if there is a
  #single element you should write it as per list syntax
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection[0].id
}

# Setting default_VPC Route into RoboVPC Private Route Table and pointing to VPC Peering Connection
resource "aws_route" "private_sub_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id = aws_route_table.private_route_table.id
  destination_cidr_block = var.default_vpc_cidr
  #Since we have set count parameter, it is treated as list, so even if there is a
  #single element you should write it as per list syntax
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection[0].id
}


# Setting default_VPC Route into RoboVPC Database Route Table and pointing to VPC Peering Connection
resource "aws_route" "database_sub_peering" {
  count = var.is_peering_required ? 1 : 0
  route_table_id = aws_route_table.database_route_table.id
  destination_cidr_block = var.default_vpc_cidr
  #Since we have set count parameter, it is treated as list, so even if there is a
  #single element you should write it as per list syntax
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection[0].id
  
}

