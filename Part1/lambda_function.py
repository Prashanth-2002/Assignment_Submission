import json
import boto3
import csv
from io import StringIO

#  we are here Initialize S3 client
s3 = boto3.client('s3')

def lambda_handler(event, context):
    bucket_name = 'info-interview-project'  #   this is the S3 bucket name
    file_name = 'dir2/file1.csv'  # Path to  file inside the bucket

    try:
        # Fetch the file from S3
        response = s3.get_object(Bucket=bucket_name, Key=file_name)
        file_content = response['Body'].read().decode('utf-8')  # Read and decode file content
        
        # Use StringIO to treat the CSV content as a file object
        csv_file = StringIO(file_content)
        csv_reader = csv.DictReader(csv_file)  # Read the CSV as a dictionary

        # Create a list of rows from the CSV
        rows = [row for row in csv_reader]

        # Return the content as JSON if it is executted successfully it returns 200 and the contents in json format
        return {
            'statusCode': 200,
            'body': json.dumps({'fileContent': rows}),
        }
    except Exception as e:
        # Return error if something goes wrong
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)}),
        }
