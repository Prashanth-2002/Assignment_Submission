AWS Infrastructure Deployment with Terraform
This project focuses on provisioning AWS infrastructure using Terraform to deploy an HTTPS service

AWS Infrastructure
This project utilizes the following AWS services:

AWS Lambda: A serverless function that fetches data from an S3 bucket(info-interview-project) and returns it in JSON format.
API Gateway: Exposes the Lambda function as an HTTPS API endpoint.
IAM Roles & Policies: Provides the necessary permissions for the Lambda function to access the S3 bucket.
S3 Bucket: Stores the file that Lambda fetches and processes.
Terraform: Used to define, configure, and deploy the AWS resources.

Terraform Configuration:
main.tf: Contains all the Terraform resources such as IAM roles, Lambda, API Gateway, etc.
Lambda Function: The Python code that fetches and processes data from the S3 bucket.
Rest all the terraform files like (.terraform.lock.htl,terraform.tfstate,terraform.tfstate.backup are configured
automatically and we do not have touch these file)

Steps to Deploy:
Initialize Terraform with terraform init.
Apply Terraform Configuration using terraform apply to provision the resources.
Verify Deployment: Terraform will output the API URL that can be used to invoke the Lambda function.
https://8u5q6jl8jg.execute-api.ap-south-1.amazonaws.com/prod/list-bucket-content
This is https link which lists contents in s3 bucket in json format
