variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}


variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
}

resource "aws_subnet" "public-subnet-1" { 
  tags = {
    Name = "public-terraform-lab-subnet-1"
  }
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.terraform-lab-vpc.id
  availability_zone = var.availability_zones[0]
    map_public_ip_on_launch = true
     

}



