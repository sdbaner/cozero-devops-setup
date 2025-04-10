
# Networking Considerations


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
10.RDS in private subnet

#### Reference architecture diagram



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

### Deploying ECS with launch type fargate
Here, the compute instances are completely managed by AWS and fargate. Only the specs like CPU, memory, vpc, image need to be defined by the user. Services can be scaled on-demand. You pay per-second for the actual time your task runs.

 
