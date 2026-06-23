import json
import boto3

s3 = boto3.client('s3')

def lambda_handler(event, context):

    file_name = event['queryStringParameters']['fileName']

    upload_url = s3.generate_presigned_url(
        'put_object',
        Params={
            'Bucket': 'file-store172',
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
            'uploadUrl': upload_url
        })
    }