import json
import boto3
import uuid
import urllib.parse
from datetime import datetime

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('FileMetadata')

def lambda_handler(event, context):

    for record in event['Records']:

        bucket_name = record['s3']['bucket']['name']
        object_key = urllib.parse.unquote_plus(record['s3']['object']['key'])

        response = s3.head_object(
            Bucket=bucket_name,
            Key=object_key
        )

        file_size = response['ContentLength']
        content_type = response['ContentType']

        table.put_item(
            Item={
                'fileid': str(uuid.uuid4()),
                'fileName': object_key.split('/')[-1],
                'fileSize': file_size,
                'contentType': content_type,
                'uploadTime': datetime.utcnow().isoformat(),
                's3Key': object_key
            }
        )

    return {
        'statusCode': 200,
        'body': json.dumps('Metadata stored successfully')
    }