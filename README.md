# Assignment_Submission

The Project is Divided into two parts :
Part 1: Lambda Function and API Gateway
This part involves creating a Lambda function that processes a CSV file from an S3 bucket and returns the data as JSON. The Lambda function is exposed through an API Gateway, which provides an HTTPS endpoint for invoking the Lambda function. The API Gateway acts as a bridge, allowing secure access to the Lambda function via HTTPS requests.

Part 2: Terraform Deployment
In this part, Terraform is used to automate the provisioning of AWS infrastructure. It creates the necessary resources, including IAM roles, policies, Lambda function, API Gateway, and the permissions needed to allow the API Gateway to invoke the Lambda function. The Terraform configuration ensures that all resources are deployed in a structured and repeatable way.
