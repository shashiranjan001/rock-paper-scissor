# placeholder for cluster id
output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

# placeholder for cluster endpoint
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

# placeholder for security group ID
output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

# placeholder for region
output "region" {
  description = "AWS region"
  value       = var.region
}

# placeholder for cluster name
output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

# placeholder for kubeconfig
locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.cluster_endpoint}
    certificate-authority-data: ${base64decode(module.eks.cluster_certificate_authority_data)}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${local.cluster_name}"
KUBECONFIG
}

# Make kubeconfig available to terraform to deploy k8s resources
output "kubeconfig" {
  value = "${local.kubeconfig}"
}
