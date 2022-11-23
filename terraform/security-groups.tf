# Create security group for node group one
resource "aws_security_group" "node_group_one" {
  name_prefix = "ws-1-node_group_one"
  vpc_id      = module.vpc.vpc_id

  # Allow ssh connections
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    # Allot cidr block for the security group
    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

