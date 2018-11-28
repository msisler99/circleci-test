
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
AWS UserCA-MMIS Platform and Tools (PAT) Naming Standards for Amazon Web Services (AWS)

The naming standards described below are designed to intelligently describe a component within the AWS world and help to quickly identify components when using the AWS management console.  
The intelligence attached to the names will reflect the account, the VPC and the subnet in order to allow the user to quickly recognize a component.  In addition to the above items, the names will sometimes show functionality of a component where applicable.
Names will follow the CamelCase naming convention in order to help the user separate parts of a name quickly.  CamelCase is a naming convention in which a name is formed of multiple words that are joined together as a single word with the first letter of each of the multiple words capitalized so that each word that makes up the name can easily be read
IPAddress
The IP Address will be designed to quickly indicate to the user which account the user is operating in.
The Development account IP addresses will follow the 10.0.x.x numbering convention.
The Stage account IP addresses will follow the 10.1.x.x numbering convention.
The Production account IP addresses will follow the 10.2.x.x numbering convention.
VPC
VPC names indicate the functionality of the VPC or more specifically to indicate what the resources in the VPC are used for.  The VPCs with an account are designed to isolate access for various groups of users. 
Examples; 
DEVPub would indicate the development account Public facing VPC
DevPriv would indicate the development account Private only VPC
DevData would indicate the development account Data VPC serving both the Public and Private VPCs
Additional VPC “Tags” can also describe the functionality of the VPC.  
Note: The Tag key value of “Name” is the “Name” value shown on the AWS management console.

Network ACL
Network ACLs control traffic at the IP level for a VPC
Mapping of network ACLs manage access to the Subnets that are associated with the ACL.
Name – Indicates which VPC this ACL is associated with. 
Examples’
DevPublicACL, DevPrivateACL, DevDataACL
Subnets
Subnet names reflect the Functionality and the availability zone (AZ) of the subnet and control inbound and outbound port types.
Subnet Functionality = Public and Private
Availability Zones – us-gov-west-2a, us-gov-west-2b
Subnets should indicate the VPC they are associated with.
Examples;
DevPublicAZA, DevPublicAZB, DevPrivateAZA, DevDataAZA….

VPC Route Tables
VPC Route Tables control access from specific IP addresses or IP address ranges at the VPC level.
Route tables are associated with a specific VPC and are associated with 1 or more subnets.
Custom route tables should only be used to allow specific IP addresses to a subnet.  
Example;
	DevPublicRt, DevPrivateRT, DevDataRT

Security Groups (SG)
Security groups control access at the Instance level across all availability zones in a VPC. 
The overall number of Security Groups can be minimized by creating "generic” security groups and associating AWS resources with the generic security groups. Security Groups should be named so as to identify the functionality.  When necessary, a Unique Security Group can be used if the functionality does not match an existing Security Group.
Security groups should have the environment, the VPC, and the functionality as part of the name in order to quickly identify them and to allow proper sorting from the AWS console.
An AWS resource can be associated with more than one Security Group. At a minimum, a resource will be associated with one Security Group depicting the functionality of the resource. This will allow the control of port access at a higher level and reduce the number of security groups required to achieve the optimum security controls.
Example Security Group names;

DevPublicALB for Development, Public, Application Load balancer
DevPrivateALB for Development, Private, Application Load balancer

Example additional functional Security Group names;

DevPublicWebServer Web Server security group for Web servers allowing ports for web Server connections
 DevPublicAppServer App Server Security Group for App servers allowing ports for App Server connections
 DevDataDBServer DB Server Security Group for DB servers allowing ports for the DB connections

EC2 instance Names (if applicable)
Server names should follow the DHCS server naming convention where possible.  Additional characters have been added and some characters have been changed in order to make the server names have more intelligence in the AWS world.
AAAVVVPPPFFFNN where:
AAA = Account (Dev, Stg, Prd) 
VVV = AWS VPC name (Pub, Prv, Dat)
PPP = Project name - the next 3 characters will be used to designate the Project that owns the server.
FFF = Server Function – the next 3 characters will be used to designate the server’s primary function.
NN =    A two-digit number from 01 to 99 - the last two characters are numerals to make each server unique.  No two servers can have the exact same name.
Example of EC2 server name applied;
DevPubFDRWeb01		Dev Pub FDR Web 01
Account, VPC, Project, Server Function, Instance Count

EC2 Tag values
Note: The Tag key value of “Name” is the “Name” value shown on the AWS management console.
The Tag key value of “Owner” will show a State Manager’s email address or Cost Center if applicable in order to track costs for usage.
Additional tags can be added to the instances to further describe the functionality of the instance.
Tags can also be added to the instance to support the use of Lambda functions such as starting up and shutting down the instance when it is not needed.
Tags can also be used for unique identifiers such as showing the group or department who uses/owns the applications on the server.
Lambda Scripts
Lamba scripts should be defined to be as generic as possible and use Tags on the instances to further refine the Lamba targets. Lambda scripts can operate on resources within any VPC or any subnet so they should be named correctly to identify their functionality. 
Example Lambda Scripts to start instances;
	 DevPubStart6AM
Account - VPC - Functionality
DevPubStart6AM – This script would automatically start instances in the Dev account, Public VPC at 6 AM daily.  The script relies on the appropriate “Tag” value associated with the instance.
DevPubStop6PM – This script would automatically stop instances in the Dev account, Public VPC at 6 PM daily.  The script relies on the appropriate “Tag” value associated with the instance.
Some Lambda scripts will be generic meaning they will operate in all VPCs, all subnets and all environments.  This type of lambda script will only name the functionality of the script and not the operating areas.
Cloud Formation Scripts
Cloud formation scripts should be used wherever possible to create resources as they can be deployed quickly and will contain much of the setup required for an instance.  Cloud formation scripts will need to be unique to VPC and subnets or will need to allow these values to be “selected” from dropdowns when run.
Key Pairs
Key Pairs are required at the time an instance is created. The key pair is the default method to allow specific types of connections to an Instance.
Key Pairs can be shared amongst EC2 instances, and should be in order to minimize key pair management.
DevPubKP01  
Dev – Pub - KP01
Account  - VPC – Key pair name and number
ROLES and Policies
Roles are required when an instance is created.
Roles are made up of a list of policies.  Policies can be added to and removed from roles as necessary.
Policies give access to components within AWS
Roles should be generic where possible so as to minimize the amount of roles to maintain.
Roles should be descriptive of their functionality.
Because roles are not specific to a VPC or a Subnet or an Environment, they can be named for their functionality as needed.
Users
	AWS Usernames will be the DHCS email username for console users.
	AWS programmatic user names should indicate the functionality of the user account.
Database Names
Databases will be named according to the environment in which they reside and their functionality, similar to EC2 instances.  A database can be associated with more than 1 availability zones (AZ) and should be where High Availability and Failover are necessary.  
Example database name;
DevDataSqlSrvDM 
Dev Data SqlSrv DM
Dev account, Data VPC, SQL Server, Data Modeling (usage)
The Tag key value of “Name” = the “Name” value shown on the AWS management console.
The Tag key value of “Owner” will identify a State Manager’s email address or Cost Center if applicable in order to track costs and/or usage.
 
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
