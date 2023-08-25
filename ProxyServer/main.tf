resource "null_resource" "squid_install" {
  provisioner "local-exec" {
    command = <<-EOT
      sudo yum install -y squid 
      sudo systemctl start squid
      sudo systemctl enable squid
      sudo systemctl status squid

      sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.bak
    EOT
  }
}

resource "local_file" "update_allowed_file" {
  filename = var.allowed_ips_file
  content  = var.myIP

  depends_on = [null_resource.squid_install]
}

resource "local_file" "update_squid_conf" {
  filename = var.target_conf_file
  content = templatefile("${path.module}/conf.tftpl", {
    allowed_ip_list = var.allowed_ips_file
  })

  depends_on = [null_resource.squid_install, local_file.update_allowed_file]
}

# resource "null_resource" "finish" {
#   provisioner "local-exec" {
#     command = <<-EOT
#       sudo systemctl restart squid
#     EOT
#   }
#   depends_on = [null_resource.squid_install, local_file.update_squid_conf]
# }
