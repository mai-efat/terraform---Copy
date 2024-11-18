


resource "aws_instance" "ec2-public-1" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.micro"
  key_name                    = "key1"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2.id]  # Ensure this security group is defined
  subnet_id                   = aws_subnet.public-subnet-1.id

    # Connection information for SSH access
  provisioner "local-exec" {
    command = "echo ${aws_instance.ec2-public-1.public_ip} >> inventory.ini"
  
  }  
  
  lifecycle {
    ignore_changes = [
      ami,               # Ignore changes to AMI
      instance_type,     # Ignore changes to instance type
      security_groups,   # Ignore changes to security groups
      subnet_id,         # Ignore changes to subnet
    ]
  }



}



data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

output "instance_public_ip" {
  value = aws_instance.ec2-public-1.public_ip
}

