data "aws_availability_zones" "azs" {
  provider = aws.region-monitoring
  state    = "available"
}


resource "aws_vpc" "aws_vpc_monitoring" {

  provider             = aws.region-monitoring
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc_monitoring"
  }

}

resource "aws_internet_gateway" "igw_monitoring" {
  provider = aws.region-monitoring
  vpc_id   = aws_vpc.aws_vpc_monitoring.id
}


resource "aws_subnet" "subnet_monitoring" {
  provider          = aws.region-monitoring
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.aws_vpc_monitoring.id
  cidr_block        = "10.0.1.0/24"
}


resource "aws_route_table" "monitoring-route" {
  provider = aws.region-monitoring
  vpc_id   = aws_vpc.aws_vpc_monitoring.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_monitoring.id

  }

  lifecycle {
    ignore_changes = all
  }

  tags = {
    Name = "Route table of the monitoring vpc"
  }
}


resource "aws_main_route_table_association" "vpc_route_asso_monitoring" {
  provider       = aws.region-monitoring
  route_table_id = aws_route_table.monitoring-route.id
  vpc_id         = aws_vpc.aws_vpc_monitoring.id

}

