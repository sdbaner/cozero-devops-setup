# Generic Variables
# region      = "eu-central-1"
environment = "dev"
project     = "cozero"


# VPC Variables
vpc                                = "vpc-cozero" 
vpc_cidr                               = "10.0.0.0/16"
azs                                = ["eu-central-1a", "eu-central-1b"]   # 
public_subnets                     = ["10.0.101.0/24","10.0.102.0/24"]    #  "10.0.103.0/24"
private_subnets                    = ["10.0.1.0/24","10.0.2.0/24"]        #  "10.0.3.0/24"
#database_subnets                   = ["10.0.151.0/24", "10.0.152.0/24"]   # "10.0.153.0/24"
enable_nat_gateway                 = true
single_nat_gateway                 = true
