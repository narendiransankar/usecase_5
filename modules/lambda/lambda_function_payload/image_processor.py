import os
import boto3
from PIL import Image
from io import BytesIO

s3 = boto3.client('s3')
sns = boto3.client('sns')

def lambda_handler(event, context):
    for record in event.get("Records", []):
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']

        response = s3.get_object(Bucket=bucket, Key=key)
        image_data = response['Body'].read()

        image = Image.open(BytesIO(image_data))
        image = image.resize((128, 128))

        buffer = BytesIO()
        image.save(buffer, format=image.format, quality=80)
        buffer.seek(0)

        dest_bucket = os.environ['DEST_BUCKET']
        dest_key = f"resized/{key}"
        s3.put_object(Bucket=dest_bucket, Key=dest_key, Body=buffer)

        sns.publish(
            TopicArn=os.environ['SNS_TOPIC'],
            Message=f"Image {key} processed and uploaded to {dest_key}"
        )
