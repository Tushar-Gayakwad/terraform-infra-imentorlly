resource "aws_vpc" "imentorlly" {
  count            = var.enable ? 1 : 0
  cidr_block       = var.ipam_pool_enable ? null : var.cidr_block
  instance_tenancy = var.instance_tenancy
  tags = {
    Name = var.tags_name
  }
}

resource "aws_subnet" "public_vpc" {
  count             = var.enable ? 1 : 0
  vpc_id            = aws_vpc.imentorlly[0].id
  availability_zone = element(var.availability_zones, 0)
  cidr_block        = var.subnet_cidr_block

  tags = {
    Name = "${var.tags_name}-subnet"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.imentorlly[0].id

  tags = {
    Name = "${var.tags_name}-igw"
  }
}

resource "aws_route_table" "custom_rt" {
  vpc_id = aws_vpc.imentorlly[0].id

  tags = {
    Name = "${var.tags_name}-route-table"
  }
}

# Define routes directly
resource "aws_route" "default_routes" {
  count = length(var.default_route_table_routes)

  route_table_id         = aws_route_table.custom_rt.id
  destination_cidr_block = var.default_route_table_routes[count.index].cidr_block
  gateway_id             = lookup(var.default_route_table_routes[count.index], "gateway_id", null)
  instance_id            = lookup(var.default_route_table_routes[count.index], "instance_id", null)
}
