### AWS CLOUDSHELL PYTHON EXAM CHEAT SHEET ###

--- 1. PRE-REQUISITE: CHECK DEFAULT VPC ---
# Run this command in terminal first.
# If it returns nothing/None, you MUST run: aws ec2 create-default-vpc
aws ec2 describe-vpcs --filters "Name=isDefault,Values=true" --query "Vpcs[0].VpcId" --output text

===============================================================

--- 2. EC2 INSTANCE (Launch & Delete) ---

# FILE 1: launch_ec2.py
import boto3

ec2 = boto3.resource('ec2')

instances = ec2.create_instances(
    ImageId='ami-02dfbd4ff395f2a1b',
    MinCount=1,
    MaxCount=1,
    InstanceType='t3.micro',
    TagSpecifications=[{
        'ResourceType': 'instance',
        'Tags': [{'Key': 'Name', 'Value': 'MyExamInstance'}]
    }]
)

print("Instance ID:", instances[0].id)

# FILE 2: terminate_ec2.py
import boto3
import sys

ec2 = boto3.resource('ec2')
instance_id = sys.argv[1]

instance = ec2.Instance(instance_id)
instance.terminate()

print("Terminated:", instance_id)

# COMMANDS TO RUN:
# python3 launch_ec2.py
# (Copy the ID, e.g., i-0xxxx)
# python3 terminate_ec2.py i-0xxxx

===============================================================

--- 3. S3 BUCKET (Create & Delete) ---

# FILE 3: create_s3.py
import boto3

s3 = boto3.client('s3', region_name='us-east-1')

bucket_name = "milan-bucket-amni9838343434"

s3.create_bucket(Bucket=bucket_name)

print("Created:", bucket_name)

# FILE 4: delete_s3.py
import boto3

s3 = boto3.client('s3', region_name='us-east-1')

bucket_name = "milan-bucket-amni9838343434"

s3.delete_bucket(Bucket=bucket_name)

print("Deleted:", bucket_name)

# COMMANDS TO RUN:
# python3 create_s3.py
# python3 delete_s3.py

===============================================================

--- 4. DYNAMODB TABLE (Create & Delete) ---

# FILE 5: create_dynamo.py
import boto3

dynamodb = boto3.resource('dynamodb')

table = dynamodb.create_table(
    TableName='MyExamTable',
    KeySchema=[{'AttributeName': 'id', 'KeyType': 'HASH'}],
    AttributeDefinitions=[{'AttributeName': 'id', 'AttributeType': 'S'}],
    ProvisionedThroughput={'ReadCapacityUnits': 1, 'WriteCapacityUnits': 1}
)

print("Creating:", table.table_name)

# FILE 6: delete_dynamo.py
import boto3

dynamodb = boto3.resource('dynamodb')

table = dynamodb.Table('MyExamTable')

table.delete()

print("Deleted table")

# COMMANDS TO RUN:
# python3 create_dynamo.py
# python3 delete_dynamo.py





