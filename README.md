# aansible-week12-configman
Configuration Management of Managed Nodes using Ansible Console Node

/* resource "null_resource" "ansible_inventory" {
  depends_on = [
    aws_instance.amazon_linux_node,
    aws_instance.ubuntu_node,
  ]

  provisioner "local-exec" {
    command = <<-EOT
      echo "[amazon_linux_nodes]" > inventory.ini
      terraform output -json amazon_linux_node_ips | jq -r '.[] | . + " ansible_ssh_user=ec2-user"' >> inventory.ini
      echo "\n[ubuntu_nodes]" >> inventory.ini
      terraform output -json ubuntu_node_ips | jq -r '.[] | . + " ansible_ssh_user=ubuntu"' >> inventory.ini
    EOT
  }
} */
