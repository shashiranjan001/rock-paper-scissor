# Kubernetes module
# host: k8s cluster api-server endpint(provided upon provisioning by aws eks)
# clustercacertificate: K8s cluster Certificate Authority
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Specify region to deploy EKS
provider "aws" {
  region = var.region
}

# Collect available AZs
data "aws_availability_zones" "available" {}

# Collect cluster id
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# Set cluster name
locals {
  cluster_name = "dev-${random_string.suffix.result}"
}

# Random string to append to cluster name
resource "random_string" "suffix" {
  length  = 8
  special = false
}

# K8s resource manifest

# Deployment Manifest
resource "kubernetes_deployment" "rps" {
  metadata {
    name = "rps"
    labels = {
      app = "rps"
    }
  }

  # 3 replicas for HA
  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "rps"
      }
    }

    template {
      metadata {
        labels = {
          app = "rps"
        }
      }

      spec {
        container {
          # Specify image
          image = "shprakas/rps-amd64:main-d3de255"
          name  = "rock-paper-scissor"
          # Container serves the application at 12000
          port {
            container_port = 12000
          }

          # Specify resource request
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

# K8s LB service manifest
resource "kubernetes_service" "rps" {
  metadata {
    name = "rps-service"
  }
  spec {
    selector = {
      app = "rps"
    }
    port {
      # Port exposed by svc
      port        = 80
      # Container serves the app at 12000 
      target_port = 12000
    }
    # Service type loadbalancer
    type = "LoadBalancer"
  }
}
