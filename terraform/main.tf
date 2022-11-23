# Kubernetes provider
# https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster#optional-configure-terraform-kubernetes-provider
# To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/terraform/kubernetes/deploy-nginx-kubernetes
# The Kubernetes provider is included in this file so the EKS module can complete successfully. Otherwise, it throws an error when creating `kubernetes_config_map.aws_auth`.
# You should **not** schedule deployments and services in this workspace. This keeps workspaces modular (one for provision EKS, another for scheduling Kubernetes resources) as per best practices.
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # load_config_file       = false
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}


locals {
  cluster_name = "dev-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

resource "kubernetes_deployment" "rps" {
  metadata {
    name = "rps"
    labels = {
      app = "rps"
    }
  }

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
          image = "shprakas/rps-amd64:main-47561a9"
          name  = "rock-paper-scissor"

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

resource "kubernetes_service" "rps" {
  metadata {
    name = "rps-service"
  }
  spec {
    selector = {
      app = "rps"
    }
    port {
      port        = 80
      target_port = 12000
    }

    type = "LoadBalancer"
  }
}
