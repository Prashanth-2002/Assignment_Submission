# Assignment_Submission

Part 1: Lambda Function and API Gateway
This part involves creating a Lambda function to process a CSV file from an S3 bucket and return the data as JSON. The function is exposed through an API Gateway, providing an HTTPS endpoint to invoke the Lambda function securely.
Live demonstration with video part1-https://drive.google.com/file/d/1o1D8sjmB2KxSimKCQlVKPPJ5WYvXQLbZ/view?usp=sharing
API  part 1-https://80k0ep7i79.execute-api.ap-south-1.amazonaws.com/new_stage/getFileContent

Part 2: Terraform Deployment
Terraform automates the provisioning of AWS infrastructure, including IAM roles, policies, Lambda, API Gateway, and the necessary permissions to allow the API Gateway to invoke the Lambda function. The Terraform configuration ensures consistent and repeatable deployment of resources.
Live demonstration with video part2-https://drive.google.com/file/d/13-Cnl1sJk3IpFE4E9idJcazIw-0G_KJj/view?usp=sharing
API  part 2-https://8u5q6jl8jg.execute-api.ap-south-1.amazonaws.com/prod/list-bucket-content
