variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "main-eks-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version to use"
  type        = string
  default     = "1.29" # You can update this to the latest stable version AWS supports
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster and nodes"
  type        = list(string)
}