import json
import boto3

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('FileMetadata')

BUCKET_NAME = 'file-store172'

def lambda_handler(event, context):

    fileid = event['queryStringParameters']['fileid']
    file_name = event['queryStringParameters']['fileName']

    try:

        # Delete file from S3
        s3.delete_object(
            Bucket=BUCKET_NAME,
            Key=file_name
        )

        # Delete metadata from DynamoDB
        table.delete_item(
            Key={
                'fileid': fileid
            }
        )

        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'message': 'File deleted successfully'
            })
        }

    except Exception as e:

        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'error': str(e)
            })
        }