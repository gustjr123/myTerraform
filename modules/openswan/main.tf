locals {
  aws_conf_path = "/etc/ipsec.d/aws.conf"
}

resource "local_file" "update_aws_conf" {
  filename = local.aws_conf_path
  content = templatefile("${path.module}/conf.tftpl", {
    LeftID       = var.leftid,
    Right1       = var.right1,
    Right2       = var.right2,
    LeftSubnet   = var.leftsubnet,
    RightSubnet1 = var.rightsubnet1,
    RightSubnet2 = var.rightsubnet2
  })

  provisioner "local-exec" {
    command = <<-EOT
    
    EOT
  }
}

resource "null_resource" "update_ipsec_secrets" {
  # 아래 내용으로 /etc/ipsec.d/aws.secrets 파일을 교체하는 local-exec 설정
  provisioner "local-exec" {
    command = <<-EOT
      cat > /etc/ipsec.d/aws.secrets <<EOF
      ${var.leftid} ${var.right1}: PSK "${var.psk1}"
      ${var.leftid} ${var.right2}: PSK "${var.psk2}"
      EOF
    EOT
  }
}

resource "null_resource" "execute_ipsec_commands" {
  # 다음 명령어를 실행하는 local-exec 설정
  provisioner "local-exec" {
    command = <<-EOT
      iptables -F
      systemctl restart ipsec
      systemctl status ipsec
    EOT
  }
  depends_on = [local_file.update_aws_conf, null_resource.update_ipsec_secrets]
}
