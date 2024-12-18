virginia_cidr = "10.10.0.0/16"
//public_subnet   = "10.10.0.0/24"
//private_subnet = "10.10.1.0/24"

subnets = ["10.10.0.0/24", "10.10.1.0/24"]

tags = {
  "env"         = "dev"
  "owner"       = "DevOps Camilo"
  "cloud"       = "aws"
  "IAC"         = "Terraform"
  "IAC_version" = "Terraform v1.10.1"
  "project"     = "cerberus"
  "region"      = "Virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami"           = "ami-0453ec754f44f9a4a"
  "instance_type" = "t2.micro"
}

enable_monitoring = "disable"

ingress_ports_list = [22, 80, 443]