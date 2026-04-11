import boto3
import os

sns = boto3.client('sns')

def lambda_handler(event, context):
    event_name = event['detail']['eventName']
    user = event['detail']['userIdentity'].get('userName', 'Unknown')
    time = event['detail']['eventTime']

    message = f"""
🚨 Security Alert!

Event: {event_name}
User: {user}
Time: {time}

Check AWS Console for details.
"""

    sns.publish(
        TopicArn=os.environ['SNS_TOPIC_ARN'],
        Message=message,
        Subject='🚨 IAM Security Alert'
    )

    return {'statusCode': 200}
