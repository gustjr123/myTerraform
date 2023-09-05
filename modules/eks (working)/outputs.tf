
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.project-eks-cluster.endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = aws_eks_cluster.project-eks-cluster.vpc_config
}

# output "region" {
#   description = "AWS region"
#   value       = var.region
# }

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = aws_eks_cluster.project-eks-cluster.name
}

