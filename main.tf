module "vpc" {
  source = "./modules/VPC"
  # variables...
}

# 1. We combined your two subnet blocks into this single block
module "subnet" {
  source       = "./modules/subnet"
  vpc_id       = module.vpc.vpc_id 
  subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  azs          = ["ap-south-1a", "ap-south-1b"]
}

# 2. Security Group (Note: it is highly recommended to rename your folder to "security_group" without a space!)
module "security_group" {
  source  = "./modules/security group" 
  vpc_id  = module.vpc.vpc_id
  sg_name = "web-sg"
}

# 3. EC2 Instance
module "ec2" {
  source            = "./modules/EC2"
  subnet_id         = module.subnet.subnet_id
  security_group_id = module.security_group.sg_id
  
  instance_type     = "t3.micro" 
  instance_name     = "ubuntu-web-server"
  vm_password       = var.vm_password 
}

# 4. Amazon EKS Cluster
module "eks" {
  source     = "./modules/EKS"
  subnet_ids = module.subnet.subnet_ids
}