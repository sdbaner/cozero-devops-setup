# IAC using terraform

This directory contains Terraform scripts for provisioning AWS resources.

This mono-repo follows a modular infrastructure-as-code approach, deploying each cloud component (e.g., VPC, ECR, RDS, ECS) using separate Terraform backends for better isolation and state management. The VPC and ECR modules are independent, whereas RDS and ECS depend on both the VPC networking layer and ECR for pulling container images.

The 'env' folder contains environment-specific variable files ( ECS, RDS, ECR, VPC, dev, etc).
The 'stack' folder contains the custom terraform modules for AWS resources like VPC, ECS, ECR, RDS etc.


#### Prerequisites
- AWS account
- IAM role to provision infrastructure on AWS
- S3 bucket for remote terraform backend

#### Folder structure

```
iac/
├── env/
│   ├── ecs.tfvars
│   ├── ecr.tfvars
│   ├── rds.tfvars
│   └── vpc.tfvars
├── stack/
│   ├── ecr/
│   │   ├── terraform.tf
│   │   ├── ecr.tf
│   │   └── variables.tf
│   │   ├── outputs.tf
│   ├── ecs/
│   │   ├── terraform.tf
│   │   ├── ecs.tf
│   │   └── variables.tf
│   │   ├── alb.tf
│   │   ├── outputs.tf
│   ├── rds/
│   │   ├── terraform.tf
│   │   ├── rds.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc/
│   |   ├── terraform.tf
│   │   ├── outputs.tf
│   |   ├── variables.tf
│   |   └── vpc.tf

```

