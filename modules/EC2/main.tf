# Dynamically fetch the latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's official AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "this" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  # The startup script that configures the password and SSH
  user_data = <<-EOF
              #!/bin/bash
              
              # 1. Set the password using Terraform variables
              echo "${var.vm_username}:${var.vm_password}" | chpasswd
              
              # 2. Enable Password Authentication
              sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
              
              if ls /etc/ssh/sshd_config.d/*.conf 1> /dev/null 2>&1; then
                sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config.d/*.conf
              fi
              
              # 3. Restart SSH
              systemctl restart sshd
              EOF
              
  tags = {
    Name = var.instance_name
  }
}