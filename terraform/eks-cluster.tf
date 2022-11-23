# EKS module
module "eks" {
  # Use terraform AWS EKS module
  source  = "terraform-aws-modules/eks/aws"

  # Use a fixed version for consistency
  version = "18.26.6"

  # Pick up cluster name from main.tf
  cluster_name    = local.cluster_name

  # Set cluster version
  cluster_version = "1.22"

  # Direct EKS to use vpc defined in vpc.tf
  vpc_id     = module.vpc.vpc_id

  # Direct EKS to use subnet defined in vpc.tf
  subnet_ids = module.vpc.private_subnets

  # Define node group defaults
  # Specify cpu_arch
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

    # Do not attach primary security group to nodegroup as it results in node being under 2 security group error
    attach_cluster_primary_security_group = false

    # Disabling and using externally provided security groups
    create_security_group = false
  }

  # Make a nodegroup
  # Specify flavor
  # Specify security group for the nodegroup
  eks_managed_node_groups = {
    one = {
      name = "worker-set-1"

      instance_types = ["t3.small"]

      vpc_security_group_ids = [
        aws_security_group.node_group_one.id
      ]
    }
  }
}