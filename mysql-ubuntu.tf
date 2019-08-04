variable "region" {
  default = "us-east-1"
}
variable "aws_profile" {
  default = "default"
}
variable "vpc_id" {
  default = "vpc-e8c8cd93"
  # VPC default
}
variable "subnet_id" {
  default = "subnet-5beb7c11"
  # use1-az4
}
variable "ssh_key" {
  default = "~/repositorios/terraform/alessander-tf.pub"
}

provider "aws" {
  region = "${var.region}"
  profile = "${var.aws_profile}"
}

resource "aws_key_pair" "mysql-ubuntu-tf" {
  key_name = "key-pair-mysql"
  public_key = "${file("${var.ssh_key}")}"
}

resource "aws_instance" "mysql-ubuntu" {
  ami           = "ami-07d0cf3af28718ef8"  # Ubuntu Server 18.04 LTS (us-east-1)
  instance_type = "t3.small"  # 2 vCPU, 2 GB RAM
  key_name = "${aws_key_pair.mysql-ubuntu-tf.id}"
  subnet_id = "${var.subnet_id}"

  depends_on = ["aws_security_group.sg_externo"]
  vpc_security_group_ids = ["${aws_security_group.sg_externo.id}",]

  associate_public_ip_address = true
  user_data = "${file("./startup-script.sh")}"

  tags {
    Name = "mysql-ubuntu"
  }

}

# Define the security group for public subnets
resource "aws_security_group" "sg_externo" {
  name = "sg_externo_mysql_ubuntu"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["187.20.141.252/32"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["187.20.141.252/32"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    # IP de casa (09/06/2018)
    cidr_blocks =  ["187.20.141.252/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    # prefix_list_ids = ["pl-12c4e678"]
  }

  vpc_id="${var.vpc_id}"

  tags {
    Name = "SG Externo - MySQL Ubuntu"
  }
}
