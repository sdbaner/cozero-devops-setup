
# Networking Considerations

#### Assumption:
A simple and small flask application and RDS deployed on ECS

## VPC Components
1. VPC in eu-central region
2. Two availavilty zones
3. Two public subnets in each AZ
4. Two private subnets in each AZ
5. One Internet gateway
6. Route table configurations 
7. Nat gateway in public subnet
8. ALB
9. ECS with fargate in private subnet
10. RDS in private subnet
11. Private Registry ECR
12. Cloudwatch for monitoring, logging and alerting

#### Reference architecture diagram

![ecs_fargate](https://github.com/user-attachments/assets/369129bd-2a0d-4818-8387-8ca47e5cce61)

Image source : internet

### VPC with public and private subnets
This is the widely used VPC setup for hosting containers and database, where the ECS and RDS reside within the private subnet with no direct access from the internet. The public subnet consists of Internet gateway to allow internet access , Application Load Balancer to host external facing services and NAT Gateway to enable outbound internet traffic from private subnet.

### NAT Gateway
You can use a network address translation (NAT) gateway to enable instances in a private subnet to connect to the internet or other AWS services, but prevent the internet from initiating a connection with those instances. In order to access internet to your private subnet, NAT Gateway must be added to Public Subnet only. For example, NAT gateway enables outbound internet traffic to pull docker image etc.

### Route table 
It contains a set of rules, called routes, that are used to determine where network traffic from your subnet or gateway is directed. To put it simply, a route table tells network packets which way they need to go to get to their destination.
- allows ingress controller in private subnet to recieve traffic from ALB in public subnet
- ensures that worker nodes can reach EKS API endpoint via a private link.
- ensures pod in private subnet can communicate with external services.

### Elastic Network Interface (ENI)
This is the network interfaces for EKS nodes, ALB, and pods (via VPC CNI).


## Deploying ECS with launch type fargate
Here, the compute instances are completely managed by AWS and fargate.Only the specs like CPU, memory, vpc, image need to be defined by the user. 
- AWS managed
- Services can be scaled on-demand.
- Pay per-second for the actual time your task runs.



 ## CIDR range considerations
- [x]  For simplicity, going with the default aws setting, "10.0.0.0/16" which 65,536 IPs, and can be used to expand multiple subnets in future.
vpc_cidr  = "10.0.0.0/16"

- [x]  Two availabilty zones are enough to provide high availabilty and fault toleration for a small and simple app.
azs  = ["eu-central-1a", "eu-central-1b"]   

- [x]  Each subnet is /24 which provides 256 IPs, which is more than enough for few ecs tasks, rds and internal communication.
  - public_subnets = ["10.0.101.0/24","10.0.102.0/24"]   
  - private_subnets = ["10.0.1.0/24","10.0.2.0/24"]        



## Security considerations
- [x]  ALB SG: Allow inbound HTTP (80) from 0.0.0.0/0
- [x]  ECS SG: Allow inbound from ALB SG on port 5000 (Flask app)
- [x]  RDS SG: Allow inbound from ECS SG on port 5432 (PostgreSQL) 
