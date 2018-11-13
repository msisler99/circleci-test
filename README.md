# AWS process to enforce Multi Factor Authentication (MFA) for all new console users

This document describes the process for an AWS administrator to follow that will force all new console users to configure MFA before accessing any AWS resources.  The link below also describes the process flow.
https://aws.amazon.com/blogs/security/how-to-delegate-management-of-multi-factor-authentication-to-aws-iam-users/

## AWS Administrator Process flow

1 Log into the AWS console and go to IAM
1 Create a group called "Force_MFA"
1 Click next until the group is created
1 Create a policy called "Force_MFA"
1 Select the "JSON" tab to edit the JSON code
1 Copy and paste the policy text from the link: https://s3.amazonaws.com/awsiammedia/public/sample/DelegateManagementofMFA/DelegateManagementofMFA_policydocument_060115.txt replacing the default JSON code in the policy
1 Replace all code values "ACCOUNT-ID-WITHOUT-HYPHENS" with your AWS account ID  
1 Click "Review Policy"
1 Name the policy "Force_MFA" and give it a description
1 Click "Create Policy"

## Attach the newly created "Force_MFA" policy to the newly created "Force_MFA" group;
1 Select Groups
1 Select "Force_MFA" group
1 Select "Attach Policy"
1 Select "Force_MFA" policy
1 Select "Attach Policy"

## Adding users 
Follow the steps below to add new AWS console users and force them to enable MFA    

1 As an AWS Administrator, add a new user
1 (IMPORTANT) Add the new user to the "Force_MFA" group first
1 Add the new user to any additional groups that are required for proper access



At this point the new user will be able to log into the console but will not be allowed access to any AWS resources until the user has enabled MFA

The following link will describe how a user can enable MFA, http://docs.aws.amazon.com/IAM/latest/UserGuide/MFADeviceSetup.html

