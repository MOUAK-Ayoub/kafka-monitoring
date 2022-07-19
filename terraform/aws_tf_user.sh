#!/bin/bash

# the shell script create a policy and attach it to a user 
# Then, the script create access keys to the user
# Finally, the script creates a bucket for storing a state file

aws iam create-policy \
 --policy-name TfUserPolicy \
 --policy-document file:///home/ansible/aws-terrraform-ansible/TfUserPolicy.json
 
sleep 5s

terraform_policy_arn=$(aws iam list-policies --query 'Policies[?PolicyName==`"TfUserPolicy"`].Arn' --output text)

aws iam create-user --user-name terraform
sleep 5s

aws iam attach-user-policy --policy-arn $terraform_policy_arn --user-name terraform
sleep 10s

aws iam create-access-key --user-name terraform > tokens.json
export TF_VAR_aws_access_key=$(jq -r '.AccessKey.AccessKeyId' tokens.json)
export TF_VAR_aws_secret_key=$(jq -r '.AccessKey.SecretAccessKey' tokens.json)
sleep 5s

aws s3api create-bucket --bucket terraformstatefile20222020

sleep 10s

terraform init -reconfigure

sleep 10s

terraform apply --auto-approve 
