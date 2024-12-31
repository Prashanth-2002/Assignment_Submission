what is HTTPS Service
This service is a small program that lets you look at the contents of a folder (called a bucket) on AWS S3 in json format.

How do you use this service?
https://h52jmkucb8.execute-api.ap-south-1.amazonaws.com/dev 
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
          
 Recommended practices:Use HTTPS  instead of HTTP to encrypt data in transit and enhance security
  Do Not Directly Use the S3 Bucket: Avoid exposing the S3 bucket in the API; use Lambda as an intermediary for secure access
  Use IAM  to grant permissions follow the principle of least privilege(Grant only permissions which are 
   required for the task)
  Error Handling: Implement error handling in the Lambda function to manage exceptions such as invalid S3 file access .
   Set an appropriate timeout for the Lambda function  ensuring it doesn't hang or timeout unexpectedly
   
   
 
