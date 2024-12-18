variable "virginia_cidr" {
  description = "The CIDR block for the VPC in Virginia"
  type        = string
  sensitive   = false
}

/*variable "public_subnet" {
    description = "CIDR public subnet"
    type = string
}

variable "private_subnet" {
    description = "CIDR private subnet"
    type = string
}*/

variable "subnets" {
  description = "List of subnets"
  type        = list(string)
}

variable "tags" {
  description = "List of tags of project"
  type        = map(string)
}

variable "sg_ingress_cidr" { // 
  description = "CIDR for ingress traffic"
  type        = string
}

variable "ec2_specs" {
  description = "Parametros de la inatancia EC2"
  type = map(string)
}

variable "enable_monitoring" {
  description = "Enable the deployment of a monitoring server"
  type        = string
}

variable "ingress_ports_list" {
  description = "List of ingress ports"
  type        = list(number)
}

variable "access_key" {

}

variable "secret_key" {
  
}