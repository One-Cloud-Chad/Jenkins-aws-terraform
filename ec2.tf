
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

data "template_file" "init" {
  template = file(var.install_jenkins)
}

resource "aws_key_pair" "tf-jenkins-aws" {
  key_name   = "tf-jenkins-aws"
  public_key = file(var.ssh_key)
}

resource "aws_instance" "jenkins-ci-vm" {
  ami             = data.aws_ami.amazon-linux-2.id
  instance_type   = (var.instance_type)
  key_name        = aws_key_pair.tf-jenkins-aws.key_name
  vpc_security_group_ids = [aws_security_group.sg_allow_jenkins.id]
  subnet_id          = aws_subnet.public-subnet-1.id
  user_data = file(var.install_jenkins)
  associate_public_ip_address = true
  tags = {
    Name = "jenkins-ci-vm"
  }
}

resource "aws_security_group" "sg_allow_jenkins" {
  name        = "allow_jenkins"
  description = "Allow SSH and Jenkins inbound traffic"
  vpc_id      = aws_vpc.development-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "icmp"
    from_port   = -1
    to_port     = -1
    cidr_blocks = [aws_vpc.development-vpc.cidr_block]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
