output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID del VPC"
}

output "subnet_ids" {
  value = {
    public_1  = aws_subnet.pub1.id
    public_2  = aws_subnet.pub2.id
    private_1 = aws_subnet.priv1.id
    private_2 = aws_subnet.priv2.id
  }
  description = "Subnets creadas"
}

output "route_table_ids" {
  value = {
    public = aws_route_table.public.id
    priv1  = aws_route_table.priv1.id
    priv2  = aws_route_table.priv2.id
  }
  description = "Tablas de ruteo"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.this.id
  description = "IGW ID"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.this.id
  description = "NAT GW ID"
}
