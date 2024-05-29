provider "aws" {
  region = var.region
}

# Criação da VPC
resource "aws_vpc" "practitioner_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Practitioner"
  }
}

# Criação do Internet Gateway
resource "aws_internet_gateway" "practitioner_igw" {
  vpc_id = aws_vpc.practitioner_vpc.id

  tags = {
    Name = "Practitioner IGW"
  }
}

# Criação da Tabela de Rotas
resource "aws_route_table" "practitioner_route_table" {
  vpc_id = aws_vpc.practitioner_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.practitioner_igw.id
  }

  tags = {
    Name = "Practitioner Route Table"
  }
}

# Associação da Tabela de Rotas com as sub-redes públicas
resource "aws_route_table_association" "public_practitioner_1_association" {
  subnet_id      = aws_subnet.public_practitioner_1.id
  route_table_id = aws_route_table.practitioner_route_table.id
}

resource "aws_route_table_association" "public_practitioner_2_association" {
  subnet_id      = aws_subnet.public_practitioner_2.id
  route_table_id = aws_route_table.practitioner_route_table.id
}

resource "aws_route_table_association" "public_practitioner_3_association" {
  subnet_id      = aws_subnet.public_practitioner_3.id
  route_table_id = aws_route_table.practitioner_route_table.id
}

# Criação das Subnets Privadas
resource "aws_subnet" "private_practitioner_1" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch  = false

  tags = {
    Name = "private_sub_01"
  }
}

resource "aws_subnet" "private_practitioner_2" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch  = false

  tags = {
    Name = "private_sub_02"
  }
}

resource "aws_subnet" "private_practitioner_3" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch  = false

  tags = {
    Name = "private_sub_03"
  }
}

# Criação das Subnets Públicas
resource "aws_subnet" "public_practitioner_1" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch  = true

  tags = {
    Name = "public_sub_04"
  }
}

resource "aws_subnet" "public_practitioner_2" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch  = true

  tags = {
    Name = "public_sub_05"
  }
}

resource "aws_subnet" "public_practitioner_3" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch  = true

  tags = {
    Name = "public_sub_06"
  }
}

# Criação da Subnet do Banco
resource "aws_subnet" "db_practitioner_1" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.7.0/24"
  map_public_ip_on_launch  = false
  availability_zone = "us-east-2a"

  tags = {
    Name = "db_sub_07"
  }
}

resource "aws_subnet" "db_practitioner_2" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.8.0/24"
  map_public_ip_on_launch  = false
  availability_zone = "us-east-2b"

  tags = {
    Name = "db_sub_08"
  }
}

resource "aws_subnet" "db_practitioner_3" {
  vpc_id     = aws_vpc.practitioner_vpc.id
  cidr_block = "10.0.9.0/24"
  map_public_ip_on_launch  = false

  tags = {
    Name = "db_sub_09"
  }
}

resource "aws_db_subnet_group" "practitioner" {
  name       = "dbpractitioner"
  subnet_ids = [
    aws_subnet.db_practitioner_1.id,
    aws_subnet.db_practitioner_2.id,
  ]

  tags = {
    Name = "Practitioner"
  }
}

resource "aws_security_group" "allow_mysql" {
  vpc_id      = aws_vpc.practitioner_vpc.id
  name        = "allow_mysql"
  description = "Allow MySQL traffic"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_mysql"
  }
}