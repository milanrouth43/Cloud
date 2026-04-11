#!/bin/bash

echo "🧹 Cleaning Compliance Lab..."

# Delete Config Rule
aws configservice delete-config-rule \
  --config-rule-name S3-Bucket-Public-Read-Prohibited 2>/dev/null

# Stop Config Recorder
aws configservice stop-configuration-recorder \
  --configuration-recorder-name default 2>/dev/null

# Delete Delivery Channel
aws configservice delete-delivery-channel \
  --delivery-channel-name default 2>/dev/null

# Delete S3 buckets
aws s3 rb s3://$(cat config-bucket.txt) --force 2>/dev/null
aws s3 rb s3://$PRIVATE_BUCKET --force 2>/dev/null
aws s3 rb s3://$PUBLIC_BUCKET --force 2>/dev/null

# Delete IAM Role
aws iam detach-role-policy \
  --role-name $ROLE_NAME \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWS_ConfigRole 2>/dev/null

aws iam delete-role \
  --role-name $ROLE_NAME 2>/dev/null

echo "✅ Cleanup completed"