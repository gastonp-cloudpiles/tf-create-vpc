locals {
  az_a = "${var.region}a"
  az_b = "${var.region}b"

  # Nombres derivados del prefijo
  vpc_name       = "${var.name_prefix}-vpc"
  igw_name       = "${var.name_prefix}-igw"
  natgw_name     = "${var.name_prefix}-natgw"
  rt_public_name = "${var.name_prefix}-rt-pub"
  rt_priv1_name  = "${var.name_prefix}-rt-priv1"
  rt_priv2_name  = "${var.name_prefix}-rt-priv2"
  pub1_name      = "${var.name_prefix}-pub1"
  pub2_name      = "${var.name_prefix}-pub2"
  priv1_name     = "${var.name_prefix}-priv1"
  priv2_name     = "${var.name_prefix}-priv2"
}

# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = local.vpc_name
  })
}

# -------------------------
# Internet Gateway
# -------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = local.igw_name
  })
}

# -------------------------
# Subnets públicas
# -------------------------
resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.pub1_cidr
  availability_zone       = local.az_a
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = local.pub1_name
    Tier = "public"
  })
}

resource "aws_subnet" "pub2" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.pub2_cidr
  availability_zone       = local.az_b
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = local.pub2_name
    Tier = "public"
  })
}

# -------------------------
# Subnets privadas
# -------------------------
resource "aws_subnet" "priv1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.priv1_cidr
  availability_zone = local.az_a

  tags = merge(var.tags, {
    Name = local.priv1_name
    Tier = "private"
  })
}

resource "aws_subnet" "priv2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.priv2_cidr
  availability_zone = local.az_b

  tags = merge(var.tags, {
    Name = local.priv2_name
    Tier = "private"
  })
}

# -------------------------
# EIP + NAT Gateway (en pub1)
# -------------------------
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = "${local.natgw_name}-eip"
  })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.allocation_id
  subnet_id     = aws_subnet.pub1.id

  tags = merge(var.tags, {
    Name = local.natgw_name
  })

  depends_on = [aws_internet_gateway.this]
}

# -------------------------
# Tablas de ruteo
# -------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = local.rt_public_name
  })
}

resource "aws_route" "public_igw_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "pub1" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pub2" {
  subnet_id      = aws_subnet.pub2.id
  route_table_id = aws_route_table.public.id
}

# Privada 1
resource "aws_route_table" "priv1" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = local.rt_priv1_name
  })
}

resource "aws_route" "priv1_nat_default" {
  route_table_id         = aws_route_table.priv1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "priv1" {
  subnet_id      = aws_subnet.priv1.id
  route_table_id = aws_route_table.priv1.id
}

# Privada 2
resource "aws_route_table" "priv2" {
  vpc_id = aws_vpc.this.id


  tags = merge(var.tags, {
    Name = local.rt_priv2_name
  })
}

resource "aws_route" "priv2_nat_default" {
  route_table_id         = aws_route_table.priv2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "priv2" {
  subnet_id      = aws_subnet.priv2.id
  route_table_id = aws_route_table.priv2.id
}
