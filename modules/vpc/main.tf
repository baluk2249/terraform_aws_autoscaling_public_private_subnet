resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc_web"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  for_each = zipmap(var.availability_zones, var.public_subnet_cidrs)
  cidr_block = each.value
  availability_zone = each.key

  tags = {
    Name = "public_subnet_${each.key}"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  for_each = zipmap(var.availability_zones, var.private_subnet_cidrs)
  cidr_block = each.value
  availability_zone = each.key

  tags = {
    Name = "private_subnet_${each.key}"
  }
  
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "nat" {
  for_each = aws_subnet.public

  tags = {
    Name = "nat_eip_${each.key}"
  }

}

resource "aws_nat_gateway" "main" {
  for_each = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = {
    Name = "nat_${each.key}"
  }
  
}



resource "aws_default_route_table" "public" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public_rt"
  }
  
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  for_each = aws_nat_gateway.main

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[each.key].id
  }

  tags = {
    Name = "private_rt_${each.key}"
  }
  
}



resource "aws_route_table_association" "private" {
  for_each = zipmap(keys(aws_subnet.private), keys(aws_route_table.private))
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.value].id
  
}

resource "aws_security_group" "web_private_asg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.web_asg_80_cidr_blocks
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.web_asg_22_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}