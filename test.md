
# Terraform scripts for creating a complete Dev AWS Data  environment. This example also uses an AWS S3 bucket and a DynamoDB table to store the Terraform state file remotely for multi user access and file locking.

The Terraform scripts will build the following AWS resources

- 1 - VPC
- 2 - Private subnets
- 2 - Public subnets
- 1 - Internet Gateway
- 2 - NAT gateways, one in each Public subnet
- 2 - Elastic IPS, one for each NAT Gateway
- 1 - Security Group for the ALB


## Pre-requisites

Prior to being able to use this Terraform infrastructure as code series of scripts, you'll need to setup the following things:

AWS Account
AWS User
Runtime Environment
S3 Bucket for State Files (bucket name must match the bucket name in the Terraform "backend.tf file")
DynamoDB table to manage locking of the state file

## AWS Account

You'll need an AWS Commercial account (i.e. not GovCloud) in order to repeatably use the Terraform scripts. Additionally, you'll need an administrator that has the ability to create new users and assign permissions.

## AWS User

Create an AWS user, with programmatic access only, and give the following permissions:

1. AmazonEC2_FullAccess
2. AmazonEKSClusterPolicy
3. AmazonDynamoDBFullAccess
4. AmazonVPCFullAccess
5. AmazonECSTaskExecutionRolePolicy
6. AmazonS3FullAccess
7. AmazonECSFullAccess

## Runtime Environment

This repository comes with a Docker image with all dependencies for running. Instructions for this are detailed in the root README.md under the "Running Commands" section. The quick reference version is:

Start Docker
Go to the root of this repo
docker build -t ca-mmis/infrastructure-private .
docker run -it --rm -v "$(pwd)":/src ca-mmis/infrastructure-private sh
aws configure
Note: When you're done, type exit. Everytime you re-enter the shell, you'll have to re-run aws configure.

## S3 Bucket for State Files

This will store the structure of what has been installed in AWS based on the Terraform script so that subsequent runs can do pinpointed updates and/or delete infrastructure.

Create an AWS S3 bucket with the whatever bucket name you want. (default values work, with versioning and encryption encouraged, but optional)
Update the bucket property in backend.tf.
Locking Mechanism

This enables Terraform to have a place to store information that indicates whether or not someone else is already running the script.  The DynamoDB table handles the locking function temporarily during an update activity and then releases the lock.

- Login to AWS and go to the DynamoDB Service.
- Create a new table with the table name that is in the backend.tf file.
- For primary key, enter the value LockID as a String
- Choose the default settings from here and click Create
- Terraform setup/usage:

Install Terraform on workstation/server for running Terraform This project uses Teraform V0.11.8 https://www.terraform.io/intro/getting-started/install.html

## Terraform commands:

***terraform init*** initializes the backend to store the state file on the S3 bucket created above. Terraform init uses the AWS CLI parameters. If using Terrafom local state store, remove the backend.tf file and the state files will be created locally.

***terraform plan*** reads all .tf files and shows the planned result without creating anything in AWS.
*"terraform apply"* reads all .tf files and applies the "planned" changes after prompting for a "yes" response.
*"terraform show"* shows the results of what is in place.
*"terraform destroy"* destroys everything created in the apply step after prompting for a "yes" response.
Command-line flags;

You can set variables directly on the command-line with the -var flag. Any command in Terraform that inspects the configuration accepts this flag, such as apply, plan, and refresh: This can be used to keep secrets out of the .tf files.

$ terraform apply 
-var 'access_key=foo' 
-var 'secret_key=bar'

## Terraform files:

All .tf files are evaluated while running the plan and apply commands

- data_main.tf contains the AWS resource creation logic
- data_backend.tf contains logic for using remote store as opposed to local store of the state file.
- variables.tf contains variable values that are referenced in the main.tf at run time.
- outputs.tf shows any outputs identified in the main.tf file. 
- The terraform.tfstate file stores the installed/built component information and is used in the destroy command as input. The .tfstate.backup file is used during updating.

## Updating installed AWS resources:

The terraform .tf scripts can be modified and then run again using the plan/apply steps and terraform will show the changes then apply them if confirmed in the apply stage.

The docker sample image source for this project is defined in the variable.tf file and points to a GitHub docker image.

The draw.io file showing this infrastructure is called PAT_AWS_Architecture.xml