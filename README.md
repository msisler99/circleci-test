# AWS process to enforce Multi Factor Authentication (MFA) for all new console users

This document describes the process for an AWS administrator to follow that will force all new console users to configure MFA before accessing any AWS resources.  The link below also describes the process flow.
https://aws.amazon.com/blogs/security/how-to-delegate-management-of-multi-factor-authentication-to-aws-iam-users/

## AWS Administrator Process flow

- Log into the AWS console and go to IAM
- Create a group called "Force_MFA"
- Click next until the group is created
- Create a policy called "Force_MFA"
- Select the "JSON" tab to edit the JSON code
- Copy and paste the policy text from the link: https://s3.amazonaws.com/awsiammedia/public/sample/DelegateManagementofMFA/DelegateManagementofMFA_policydocument_060115.txt replacing the default JSON code in the policy
- Replace all code values "ACCOUNT-ID-WITHOUT-HYPHENS" with your AWS account ID  
- Click "Review Policy"
- Name the policy "Force_MFA" and give it a description
- Click "Create Policy"

## Attach the newly created "Force_MFA" policy to the newly created "Force_MFA" group;
- Select Groups
- Select "Force_MFA" group
- Select "Attach Policy"
- Select "Force_MFA" policy
- Select "Attach Policy"

## Adding users 
Follow the steps below to add new AWS console users and force them to enable MFA    

- As an AWS Administrator, add a new user
- (IMPORTANT) Add the new user to the "Force_MFA" group first
- Add the new user to any additional groups that are required for proper access



At this point the new user will be able to log into the console but will not be allowed access to any AWS resources until the user has enabled MFA

The following link will describe how a user can enable MFA, http://docs.aws.amazon.com/IAM/latest/UserGuide/MFADeviceSetup.html

