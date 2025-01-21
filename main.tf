terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.69.0"
    }
  }
  required_version = ">= 1.9.5"
}

provider "aws" {
  region     = "eu-west-2"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_KEY_ID
}

variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_KEY_ID" {}

# Create Security Group for EC2 web and app servers  
resource "aws_security_group" "invent_sg" {
  name        = "INVENT-SG"
  description = "Security Group for web servers"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Ansible Control Node
resource "aws_instance" "ansible_control_node" {
  ami           = "ami-0c76bd4bd302b30ec"
  instance_type = "t2.micro"
  key_name               = "Ans-Auth"
  vpc_security_group_ids = [aws_security_group.invent_sg.id]

  tags = {
    Name = "AnsibleControlNode"
    Time-Created = formatdate("MM DD YYYY hh:mm ZZZ", timestamp())
    Department   = "DevOps Management"
  }
}

# Creation of Managed Nodes (Amazon Linux and Ubuntu Machines)  

resource "aws_instance" "amazon_linux_node" {
  count                  = 3
  ami                    = "ami-0c76bd4bd302b30ec"
  instance_type          = "t2.micro"
  key_name               = "Ans-Auth"
  vpc_security_group_ids = [aws_security_group.invent_sg.id]

  tags = {
    Name         = "WebAmazonLinuxNode-${count.index + 1}"
    Time-Created = formatdate("MM DD YYYY hh:mm ZZZ", timestamp())
    Department   = "Dev Team"
  }
}

resource "aws_instance" "ubuntu_node" {
  count                  = 3
  ami                    = "ami-091f18e98bc129c4e"
  instance_type          = "t2.micro"
  key_name               = "Ans-Auth"
  vpc_security_group_ids = [aws_security_group.invent_sg.id]

  tags = {
    Name         = "AppUbuntuNode-${count.index + 1}"
    Time-Created = formatdate("MM DD YYYY hh:mm ZZZ", timestamp())
    Department   = "Prod Team"
  }
}

# Generate Ansible Inventory

/* resource "null_resource" "ansible_inventory" {
  triggers = {
    instance_ids = "${join(",", aws_instance.amazon_linux_node[*].id)}"
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "[ansible_control_node]" > inventory.ini
      echo "${aws_instance.ansible_control_node.public_ip}" >> inventory.ini
      echo "\n[amazon_linux_nodes]" >> inventory.ini
      echo "${join("\n", aws_instance.amazon_linux_node[*].public_ip)}" >> inventory.ini
      echo "\n[ubuntu_nodes]" >> inventory.ini
      echo "${join("\n", aws_instance.ubuntu_node[*].public_ip)}" >> inventory.ini
    EOT
  }
} */

resource "null_resource" "ansible_inventory" {
  depends_on = [
    aws_instance.amazon_linux_node,
    aws_instance.ubuntu_node,
  ]

  provisioner "local-exec" {
    command = <<-EOT
      echo "[amazon_linux_nodes]" >> inventory.ini
      echo "${join("\\n", aws_instance.amazon_linux_node[*].public_ip)}" >> inventory.ini
      echo "\\n[ubuntu_nodes]" >> inventory.ini
      echo "${join("\\n", aws_instance.ubuntu_node[*].public_ip)}" >> inventory.ini
    EOT
  }
}

