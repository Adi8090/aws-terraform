# ==========================================
# 1. IAM ROLE FOR THE EKS CONTROL PLANE
# ==========================================

resource "aws_iam_role" "cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

# Attach the required AWS managed policy for the Cluster
resource "aws_iam_role_policy_attachment" "cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}


# ==========================================
# 2. IAM ROLE FOR THE WORKER NODES
# ==========================================

resource "aws_iam_role" "node_role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach the 3 required AWS managed policies for Worker Nodes
resource "aws_iam_role_policy_attachment" "node_worker_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "node_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" # Manages Pod Networking
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "node_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" # Allows pulling Docker images
  role       = aws_iam_role.node_role.name
}

# ==========================================
# 3. THE EKS CONTROL PLANE (THE BRAIN)
# ==========================================

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn
  version  = var.cluster_version

  vpc_config {
    # EKS requires at least 2 subnets in different Availability Zones
    subnet_ids = var.subnet_ids
  }

  # Ensure the IAM Role permissions are fully created before building the cluster
  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
}

# ==========================================
# 4. THE EKS NODE GROUP (THE WORKERS)
# ==========================================

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.subnet_ids

  # How many EC2 instances should run your containers?
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  # Note: t3.micro is too small for EKS because Kubernetes system pods consume a lot of memory. 
  # t3.medium is the recommended minimum for worker nodes.
  instance_types = ["t3.medium"] 

  # Ensure all Node IAM permissions are ready before launching the servers
  depends_on = [
    aws_iam_role_policy_attachment.node_worker_policy,
    aws_iam_role_policy_attachment.node_cni_policy,
    aws_iam_role_policy_attachment.node_registry_policy,
  ]
}