what is HTTPS Service
This service is a small program that lets you look at the contents of a folder (called a bucket) on AWS S3 in json format.

How do you use this service?
https://80k0ep7i79.execute-api.ap-south-1.amazonaws.com/new_stage/getFileContent 
just paste this link in any browser,

Bucket Structure:
info-interview-project/  (Bucket name)
    ├── dir1/
    ├── dir2/
    │   └── file1.csv

Working : API Gateway: Triggers the Lambda function when an HTTPS request is made.
          Lambda: Retrieves content from the  S3 bucket(info-interview-project).
          Fetch Data from S3: Lambda fetches the file (CSV) from S3.
          Process Data: Lambda processes and converts the data into JSON format .
          Return Data: the data is returned in  JSON format.
          
Use HTTPS: Always use HTTPS to encrypt data in transit and enhance security.
Avoid Direct S3 Access: Do not expose the S3 bucket in APIs; use a Lambda function as an intermediary for secure access.
IAM Best Practices: Grant permissions following the principle of least privilege—provide only the permissions required for the task.
Error Handling: Implement robust error handling in Lambda to manage exceptions, such as invalid S3 file access.
Timeout Settings: Set appropriate timeouts for Lambda functions to prevent unexpected delays or failures.

Challeneges I faced:
I had some issues in permissions,i had some difficulty to give lambda appropriate permissions to acess the s3 bucket
 Initially, error handling was not  being implemented, but after watching some YouTube tutorials, I discovered an effective solution.

   
   
   
 
