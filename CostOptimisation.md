# Cost Optimization in a DevOps Cloud Environment 


Since this is a simple docker app with rds running its infrastructure on AWS. Below measures have been implemented to optimize cloud cost:
- [x]  Using AWS free-tier credits as much as possible
- [x]  Using two AvailabiltyZones instead of three to provide HA and fault tolerance.
- [x]  Using Fargate with ECS to go with pay per-second for the actual time the task runs.
- [x]  Using GitHub-hosted runners instead of maintaining self-hosted runners.
- [x]  Created a lifecycle policy in ECR to automatically delete older, unused images beyond a certain retention threshold.
- [x]  Using a single ALB for current/future container services.
- [x]  Modify the pipeline to trigger builds only on changes to specific directories to reduce consuming unnecessary compute resources for each build cycle.
- [ ]   Check about ECR/ VNET gateway pricing




### Below are some possible issues and their cost effective approaces..

Issue 1: Over-Provisioned EC2 Instances
 • The company used large EC2 instances for staging and development, running 24/7.
 • Many instances were idle during non-business hours.

Solution:
 • Implement auto-scaling for production workloads.
 • Switched to spot instances for non-critical batch processing.

------------
Issue 2: High Log Storage Costs
 • Application logs were stored in Amazon S3 with no retention policy, leading to terabytes of data.

Solution:
 • Move old logs to S3 Glacier for cheaper long-term storage.
 • Apply lifecycle policies to auto-delete logs older than 90 days.



-------------




