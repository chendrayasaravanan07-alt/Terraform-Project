import json
import boto3

s3 = boto3.client('s3')

BUCKET_NAME = 'file-store172'

def lambda_handler(event, context):

    file_name = event['queryStringParameters']['fileName']

    url = s3.generate_presigned_url(
        'get_object',
        Params={
            'Bucket': BUCKET_NAME,
            'Key': file_name
        },
        ExpiresIn=300
    )

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({
            'downloadUrl': url
        })
    }