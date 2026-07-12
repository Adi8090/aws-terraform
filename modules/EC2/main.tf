data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"] 
  }
}

resource "aws_instance" "this" {
  ami                    = "ami-01a00762f46d584a1"
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  credit_specification {
    cpu_credits = "standard"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "${var.vm_username}:${var.vm_password}" | chpasswd
              sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
              if ls /etc/ssh/sshd_config.d/*.conf 1> /dev/null 2>&1; then
                sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config.d/*.conf
              fi
              systemctl restart sshd
              EOF

  tags = {
    Name = var.instance_name
  }
}