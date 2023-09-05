# EKS를 위한 NAT 인스턴스 생성
resource "aws_security_group" "security_group" {
  name        = "${var.nat_name}_security_group"
  description = "Security group for NAT instance ${var.nat_name}"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Ingress CIDR"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = [var.security_group_ingress_cidr_ipv4]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]

  egress = [
    {
      description      = "Default egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
    }
  ]
}

resource "aws_instance" "nat_instance" {
  ami           = var.nat_ami_id
  instance_type = "t2.micro"
  count         = 1
  key_name      = var.ssh_key_name
  network_interface {
    network_interface_id = aws_network_interface.network_interface.id
    device_index         = 0
  }
  user_data = <<EOT
#!/bin/bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo yum install -y iptables-services
sudo service iptables save
  EOT

  tags = {
    Name = var.nat_name
    Role = "nat"
  }
}

# use this network interface for the private subnet route table route
resource "aws_network_interface" "network_interface" {
  subnet_id         = var.nat_subnet_id
  source_dest_check = false
  security_groups   = [aws_security_group.security_group.id]

  tags = {
    Name = "${var.nat_name}_network_interface"
  }
}

resource "aws_eip" "nat_public_ip" {
  instance = aws_instance.nat_instance[0].id
  domain   = "vpc"
}

resource "aws_route" "rtb" {
  route_table_id         = var.nat_rtb_id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.network_interface.id
  depends_on             = [aws_instance.nat_instance, aws_network_interface.network_interface]
}

# EKS Cluster IAM
data "aws_iam_policy_document" "eks-assume-role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks-cluster-role" {
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.eks-assume-role.json
  depends_on         = [aws_instance.nat_instance]
}

resource "aws_iam_role_policy_attachment" "project-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-cluster-role.name
  depends_on = [aws_iam_role.eks-cluster-role]
}
resource "aws_iam_role_policy_attachment" "project-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
  depends_on = [aws_iam_role.eks-cluster-role]
}

# aws_eks_cluster
resource "aws_eks_cluster" "project-eks-cluster" {
  # 1. 클러스터 구성
  name     = var.cluster_name                  # 이름 (필수)
  version  = "1.27"                            # 버전
  role_arn = aws_iam_role.eks-cluster-role.arn # 클러스터 서비스 역할 (필수)

  # 2. 네트워킹 지정
  vpc_config {
    subnet_ids              = var.subnet_ids             # 필수
    security_group_ids      = var.cluster_security_group # 필수
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  kubernetes_network_config {
    ip_family = "ipv4"
  }

  # 3. Configure logging
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role.eks-cluster-role
  ]
}
# coredns: v1.10.1-eksbuild.1
# kube-proxy: v1.27.1-eksbuild.1
# vpc-cni: v1.12.6-eksbuild.2
resource "aws_eks_addon" "pj-kube-proxy" {
  cluster_name                = aws_eks_cluster.project-eks-cluster.id
  addon_name                  = "kube-proxy"
  addon_version               = "v1.27.1-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"
  depends_on                  = [aws_eks_cluster.project-eks-cluster]
}
resource "aws_eks_addon" "pj-vpc-cni" {
  cluster_name                = aws_eks_cluster.project-eks-cluster.id
  addon_name                  = "vpc-cni"
  addon_version               = "v1.12.6-eksbuild.2"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  depends_on = [aws_eks_cluster.project-eks-cluster]
}
# Node Group IAM
data "aws_iam_policy_document" "ng-assume-role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "node-group-role" {
  name               = "node-group-role"
  assume_role_policy = data.aws_iam_policy_document.ng-assume-role.json
}
resource "aws_iam_role_policy_attachment" "project-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-group-role.name
  depends_on = [aws_iam_role.node-group-role]
}
resource "aws_iam_role_policy_attachment" "project-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-group-role.name
  depends_on = [aws_iam_role.node-group-role]
}
resource "aws_iam_role_policy_attachment" "project-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-group-role.name
  depends_on = [aws_iam_role.node-group-role]
}

# AMI 릴리스
data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.project-eks-cluster.version}/amazon-linux-2/recommended/release_version"
}
resource "aws_eks_node_group" "project-node-group" {
  cluster_name    = aws_eks_cluster.project-eks-cluster.name
  node_group_name = "project-node-group"
  version         = aws_eks_cluster.project-eks-cluster.version
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  node_role_arn   = aws_iam_role.node-group-role.arn
  subnet_ids      = var.pvt_subnet_ids
  instance_types  = ["t2.micro"]

  remote_access {
    ec2_ssh_key = var.ssh_key_name
  }

  scaling_config {
    desired_size = 4
    max_size     = 6
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Optional: Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role.node-group-role
  ]
}
resource "aws_eks_addon" "pj-coredns" {
  cluster_name                = aws_eks_cluster.project-eks-cluster.id
  addon_name                  = "coredns"
  addon_version               = "v1.10.1-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE" # NONE, OVERWRITE, PRESERVE
  depends_on                  = [aws_eks_node_group.project-node-group]
}

# OIDC, ALB IAM
data "tls_certificate" "project-eks-cluster-url" {
  url        = aws_eks_cluster.project-eks-cluster.identity[0].oidc[0].issuer
  depends_on = [aws_eks_cluster.project-eks-cluster]
}

resource "aws_iam_openid_connect_provider" "project-oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.project-eks-cluster-url.certificates[*].sha1_fingerprint
  url             = data.tls_certificate.project-eks-cluster-url.url
  depends_on      = [data.tls_certificate.project-eks-cluster-url]
}

data "aws_iam_policy_document" "project-alb-controller-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.project-oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.project-oidc.arn]
      type        = "Federated"
    }
  }
  depends_on = [aws_iam_openid_connect_provider.project-oidc]
}
resource "aws_iam_role" "project-alb-controller-role" {
  assume_role_policy = data.aws_iam_policy_document.project-alb-controller-policy.json
  name               = "project-vpc-cni-role"
  depends_on         = [data.aws_iam_policy_document.project-alb-controller-policy]
}
resource "aws_iam_policy" "project-ALBControllerPolicy" {
  name   = "project-ALBControllerPolicy"
  policy = templatefile("./alb-policy.json.tftpl", {})
}
resource "aws_iam_role_policy_attachment" "project-AmazonALBCPolicy" {
  policy_arn = aws_iam_policy.project-ALBControllerPolicy.arn
  role       = aws_iam_role.project-alb-controller-role.name
  depends_on = [
    aws_iam_role.project-alb-controller-role,
    aws_iam_policy.project-ALBControllerPolicy
  ]
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks --region ap-northeast-2 update-kubeconfig --name ${var.cluster_name}"
  }
  depends_on = [
    aws_eks_cluster.project-eks-cluster
  ]
}
