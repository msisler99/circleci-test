# The services folder will support creating individual services as needed for review.

 This folder will be used for creating and deploying services on demand.  The creation of a service will be triggered by a GitHub Pull Request on a source code repository. The CI tool will perform the build of the services based on a combination of Terraform scripts, Shell scripts and manifest files that will determine how the service is built and where it is deployed.  Each service will have a unique Terraform state file stored in an AWS S3 bucket with the Pull Request in the file name.  The CI tool will also perform a Terraform "destroy" when the Pull Request is closed and will completely remove the service from it's deployed location.

##  The files in this directory should remain stable and should be parameter driven by the CI tool to build unique services. 

- Terraform script files    (used to configure the services built)
- Shell scripts             (used to configure the services built)
- Manifest files            (used to configure dependencies during a build)
- Config.yml files          (used by the CI tool to orchestrate the build, deployment and removal of a service)
