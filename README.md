# circleci-test
Describe the process that will be used to for Multi Factor Authentication (MFA) for all AWS users.
Terraform scripts for creating a complete functioning AWS environment. All the AWS resources are created from within Terraform scripts This example also uses an AWS S3 bucket and a DynamoDB table to store the Terraform state file remotely for multi user access and file locking.
The Terraform scripts will build the following AWS resources
1 - VPC 2 - Public subnets 2 - Private subnets 1 - load balancer (ALB) 1 - target group 2 - NAT gateways, one in each Public subnet 1 - Fargate cluster 1 - Service in the cluster 2 - Tasks running in the service 1 - Internet Gateway 2 - Security Groups, one for the ALB and 1 for the Cluster 2 - Elastic IPS, one for each NAT Gateway Pre-requisites
Prior to being able to use this Terraform infrastructure as code series of scripts, you'll need to setup the following things:
AWS Account AWS User Runtime Environment S3 Bucket for State Files DynamoDB table to manage locking of the state file
AWS Account
You'll need an AWS Commercial account (i.e. not GovCloud) in order to repeatably use the Terraform scripts. Additionally, you'll need an administrator that has the ability to create new users and assign permissions.
AWS User
Create an AWS user, with programmatic access only, and give the following permissions:
AmazonEC2_FullAccess AmazonEKSClusterPolicy AmazonDynamoDBFullAccess AmazonVPCFullAccess AmazonECSTaskExecutionRolePolicy AmazonS3FullAccess AmazonECSFullAccess Runtime Environment
