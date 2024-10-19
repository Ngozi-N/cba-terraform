provider "aws" {
 region = var.region
}

resource "aws_security_group" "cba_tf_sg1" {
 name        = "cba_tf_sg1"
 description = "allow all traffic"
 ingress {
   from_port  = 22
   to_port    = 22
   protocol   = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   from_port  = 80
   to_port    = 80
   protocol   = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
   from_port  = 0
   to_port    = 0
   protocol   = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
   name = "CBAterraformSG1"
 }
}

data "aws_key_pair" "sample_kp" {
  key_name = var.key_name
}

resource "aws_instance" "cba_tf_instance1" {
  instance_type = var.instance_type
  security_groups = [aws_security_group.cba_tf_sg1.name]
  ami = var.instance_ami
  key_name = var.key_name
  user_data = file("install_apache.sh")

  tags = {
    Name = "CBATerraformInstance"
    }
}