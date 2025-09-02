region  = "us-east-1"
project = "ecs-network"
owner   = "gaston"
env     = "lab"

vpc_name   = "ecs-vpc"
igw_name   = "ecs-igw"
natgw_name = "ecs-natgw"

rt_public_name = "ecs-rt-pub"
rt_priv1_name  = "ecs-rt-priv1"
rt_priv2_name  = "ecs-rt-priv2"

pub1_name  = "ecs-pub1"
pub2_name  = "ecs-pub2"
priv1_name = "ecs-priv1"
priv2_name = "ecs-priv2"

vpc_cidr   = "192.168.0.0/16"
pub1_cidr  = "192.168.10.0/24"
pub2_cidr  = "192.168.20.0/24"
priv1_cidr = "192.168.30.0/24"
priv2_cidr = "192.168.40.0/24"

tags = {
  CostCenter = "lab"
}
