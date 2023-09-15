locals {
  aws_conf_path    = "/etc/ipsec.d/aws.conf"
  sysctl_conf_path = "/etc/sysctl.conf"
}

resource "null_resource" "ipsec_install" {
  provisioner "local-exec" {
    command = "sudo yum -y install openswan"
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
    sudo systemctl stop ipsec
    sudo systemctl disable ipsec
    sudo yum -y remove libreswan
    EOT
  }
}

resource "local_file" "update_sysctl_conf" {
  filename = local.sysctl_conf_path
  content  = templatefile("${path.module}/sysctl.tftpl", {})

  provisioner "local-exec" {
    command = "sudo sysctl -p"
  }

  depends_on = [null_resource.ipsec_install]
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

  depends_on = [null_resource.ipsec_install]
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

  depends_on = [local_file.update_aws_conf, local_file.update_sysctl_conf]
}

resource "null_resource" "execute_ipsec_commands" {
  # 다음 명령어를 실행하는 local-exec 설정
  provisioner "local-exec" {
    command = <<-EOT
      sudo iptables -F
      sudo systemctl restart ipsec
      sudo systemctl status ipsec
    EOT
  }
  depends_on = [null_resource.update_ipsec_secrets]
}

resource "null_resource" "output_message" {
  provisioner "local-exec" {
    command = <<EOT
    echo "Successful Set up Ipsec"
    echo "Check your status"
    echo "sudo systemctl status ipsec"
    echo "sudo rpm -ql libreswan"
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<-EOT
    echo "Destroy Ipsec"
    echo "Check your status"
    echo "sudo systemctl status ipsec"
    echo "sudo rpm -ql libreswan"
    EOT
  }
}
