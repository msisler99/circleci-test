# circleci-test
## Using Circleci and Terraform to create and maintain AWS resources when Infrastructure code is Committed to a specific GitHub repository.

## General process flow:
This repository can be "linked" to a CircleCi project that monitors for GitHub commits. When an artifact is commited to the repository, CircleCi wakes up and performs the following steps:

- Downloads a docker image in which to run the Terraform commands.
- Downloads the contents of the GitHub repository to the docker image.
- Runs a Terraform "init" command to create/update the Terraform remote state file stored on S3.
- Runs a Terraform "plan" command to show the proposed changes.
- Runs a Terraform "apply" command to apply the changes to the AWS environment.
- Exits and deletes the docker image when completed successfully.

## Dependencies:
- An AWS IAM user with appropriate permissions needs to be created and the credentials placed in the CircleCi project.
- An AWS S3 bucket needs to be created to store Terraform state file.
- An AWS DynamoDB table needs to be created to maintain lock state for the Teraform state file.
- A CircleCi project must be created that is linked to this repository.
- Refer to https://github.com/ca-mmis/infrastructure-private/blob/master/prototype/README.md for setting up the AWS IAM user, creating an AWS S3 bucket and creating the necessary DynamoDB table.

