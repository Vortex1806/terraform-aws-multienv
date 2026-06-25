#key-value-pair
resource "aws_key_pair" "my_key_name" {
  key_name   = "${var.env}-terra-auto-key"
  public_key = file("../../terra-auto-key.pub")
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

# Security group

resource "aws_security_group" "terra_sg" {
  name        = "${var.env}-terra_security_group"
  description = "terraform sg"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "terraform_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.terra_sg.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 22
  ip_protocol       = "tcp" 
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.terra_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Instance
resource "aws_instance" "my_instance" {
  count = var.ec2_instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  key_name = aws_key_pair.my_key_name.key_name
  #EBS
  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.env}-${var.instance_name}-${count.index + 1}"
    Environment = var.env
  }
}
