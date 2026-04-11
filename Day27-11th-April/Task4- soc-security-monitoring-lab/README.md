# SOC Security Monitoring Lab

This project implements a real-time AWS security monitoring pipeline.

## Services Used
- CloudTrail (logging)
- S3 (log storage)
- EventBridge (event detection)
- Lambda (processing)
- SNS (alerts)

## Flow
IAM Event → CloudTrail → EventBridge → Lambda → SNS → Email

## Files
- cloudtrail-bucket-policy.json
- lambda_function.py
- cleanup.sh

## Notes
Replace:
- REPLACE_BUCKET with your S3 bucket name
- ACCOUNT_ID with your AWS account ID
