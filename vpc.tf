resource "aws_vpc" "vpc_virginia" { // Creamos una virtual private cloud
  cidr_block = var.virginia_cidr
  tags = {
    Name = "VPC_VIRGINIA-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" { // Creamos una subnet pública
  vpc_id                  = aws_vpc.vpc_virginia.id // Asociamos la subnet publica a la vpc
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "PUBLIC_SUBNET-${local.sufix}"
  }
}

resource "aws_subnet" "private_subnet" { // Creamos una subnet privada
  vpc_id     = aws_vpc.vpc_virginia.id // Asociamos la subnet privada a la vpc
  cidr_block = var.subnets[1]
  tags = {
    Name = "PRIVATE_SUBNET-${local.sufix}"
  }

  depends_on = [aws_subnet.public_subnet]
}

resource "aws_internet_gateway" "igw" { //Creamos un internet gateway para que se pueda conectar nuestra subnet pública a internet
  vpc_id = aws_vpc.vpc_virginia.id // Asociamos el internet gateway a la vpc de virginia
  tags = {
    Name = "INTERNET_GATEWAY_VPC_VIRGINIA-${local.sufix}"
  }
}

resource "aws_route_table" "public_CustomRouteTable" { // Creamos una tabla de enrutamiento
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0" // Ruta por defecto
    gateway_id = aws_internet_gateway.igw.id // Agregamos el internet gateway a la tabla de enrutamiento
  }

  tags = {
    Name = "PUBLIC_CRT"
  }
}

resource "aws_route_table_association" "public_CustomRouteTable_association" { // Asociamos la tabla de enrutamiento a la subnet publica
  subnet_id = aws_subnet.public_subnet.id // Asociamos la subnet publica a la tabla de enrutamiento
  route_table_id = aws_route_table.public_CustomRouteTable.id // Asociamos la tabla de enrutamiento a la subnet publica
}

resource "aws_security_group" "sg_public_instance" { // Creamos un security group
  name        = "Public Instance SG" // Nombre del security group
  description = "Allow SSH inbound traffic and ALL egress traffic" // Descripcion
  vpc_id      = aws_vpc.vpc_virginia.id // Asociamos el security group a la vpc

  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }

  egress { // Reglas de salida
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = [ "::/0" ]
  }

  tags = {
    Name = "SECURITY_GROUP-${local.sufix}"
  }
}