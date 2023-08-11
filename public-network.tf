#AWS resource to create a VPC CIDR Block and to enable a DNS hostname to the instances
resource "aws_vpc" "boundary_ingress_worker_vpc" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "Boundary Ingress Worker Public VPC CIDR Block"
  }
}

# Create a Public subnet and assign to the VPC. The NAT gateway will be associated to this subnet
resource "aws_subnet" "boundary_ingress_worker_subnet" {
  vpc_id                  = aws_vpc.boundary_ingress_worker_vpc.id
  cidr_block              = var.aws_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    Name = "Boundary Ingress Worker Public Subnet"
  }
}

# AWS resource to create the Internet Gateway
resource "aws_internet_gateway" "boundary_ingress_worker_ig" {
  vpc_id = aws_vpc.boundary_ingress_worker_vpc.id
  tags = {
    Name = "boundary-worker-igw"
  }
}

//AWS resource to create a route table with a default route pointing to the IGW

resource "aws_route_table" "boundary_ingress_worker_public_rt" {
  vpc_id = aws_vpc.boundary_ingress_worker_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.boundary_ingress_worker_ig.id
  }
  tags = {
    Name = "boundary-ingress-worker-public-rt"
  }

}

# AWS resource to associate the route table to the CIDR blocks created
resource "aws_route_table_association" "boundary_ingress_worker_public_rt_associate" {
  subnet_id      = aws_subnet.boundary_ingress_worker_subnet.id
  route_table_id = aws_route_table.boundary_ingress_worker_public_rt.id
}
