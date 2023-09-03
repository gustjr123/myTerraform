locals {
  allowed_ips_file = "/etc/squid/allowed_ips.txt"
  target_conf_file = "/etc/squid/squid.conf"
}

resource "null_resource" "squid_install" {
  provisioner "local-exec" {
    command = "sudo yum -y install squid"
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
    sudo systemctl stop squid
    sudo systemctl disable squid
    sudo yum -y remove squid
    sudo rm -rf /etc/squid/
    EOT
  }
}

resource "local_file" "update_allowed_file" {
  filename = local.allowed_ips_file
  content  = var.IP

  depends_on = [null_resource.squid_install]
}

resource "local_file" "update_squid_conf" {
  filename = local.target_conf_file
  content = templatefile("${path.module}/conf.tftpl", {
    allowed_ip_list = local.allowed_ips_file
  })

  depends_on = [null_resource.squid_install, local_file.update_allowed_file]

  provisioner "local-exec" {
    command = <<-EOT
    sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak
    printf "${var.user}:$(openssl passwd -crypt ${var.password})\n" | sudo tee -a /etc/squid/htpasswd
    sudo systemctl enable --now squid
    sudo systemctl restart squid
    sudo systemctl status squid
    EOT
  }
}
