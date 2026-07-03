module "vpc" {
  source   = "./modules/VPC"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "production-vpc"
}

module "subnet" {
  source      = "./modules/subnet"
  vpc_id      = module.vpc.vpc_id # Pulling the ID from the VPC module output
  subnet_cidr = "10.0.1.0/24"
}

module "security_group" {
  source  = "./modules/security group" # (Update this if you remove the space in the folder name)
  vpc_id  = module.vpc.vpc_id
  sg_name = "web-sg"
}

module "ec2" {
  source            = "./modules/EC2"
  subnet_id         = module.subnet.subnet_id
  security_group_id = module.security_group.sg_id
  instance_type     = "t3.micro" # <--- Change this to t3.micro
  instance_name     = "ubuntu-web-server"
  vm_password       = var.vm_password 
}

