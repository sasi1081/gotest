#!/bin/bash
set -x

echo "To deploy Kubes cluster in AWS"

export IAM_PROVISIONing_ROLE=IAMProvisioningRole
export IAM_PROVISIONing_ROLE_ARN =''
export AWS_REGION = ap-southeast-2

AWS_STS_ASSUME_ROLE_OUTPUT_JSON=$(aws sts assume-role --role-arn "${IAM_PROVISIONing_ROLE_ARN}" --role-session-name "${IAM_PROVISIONing_ROLE}")
AWS_ACCESS_KEY_ID =$(echo "{AWS_STS_ASSUME_ROLE_OUTPUT_JSON}" | jq -r .Credentials.AccessKeyid)
AWS_SECRET_ACCESS_KEY_ID =$(echo "{AWS_STS_ASSUME_ROLE_OUTPUT_JSON}" | jq -r .Credentials.SecretAccessKeyid)
AWS_SESSION_TOKEN =$(echo "{AWS_STS_ASSUME_ROLE_OUTPUT_JSON}" | jq -r .Credentials.SessionToken)


aws ec2 delete-key-pair --key-name gotest
rm -rf gotest

aws ec2 create-key-pair --key-name gotest --query 'Key<aterial' --output text > gotest
chcmod 400 gotest

aws ssm delete-parameter --name "/sasi/gotest"
aws ssm put-parameter --name "/sasi/gotest" --type SecureString --value file://gotest


echo "Running terraform deployment.. Please standby"

if ["$mode == "create""]; then

terraform validate
terraform init

terraform plan

terraform apply -auto-approve

fi


if ["$mode == "destroy"]; then
terraform delete -auto-approve

fi
rm -f gotest


