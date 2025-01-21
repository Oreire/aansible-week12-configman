

output "ansible_control_node_ip" {
  value = aws_instance.ansible_control_node.public_ip
}

output "amazon_linux_node_ips" {
  value = [for instance in aws_instance.amazon_linux_node : instance.public_ip]
}

output "ubuntu_node_ips" {
  value = [for instance in aws_instance.ubuntu_node : instance.public_ip]
}
