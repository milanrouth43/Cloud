#!/bin/bash

echo "🧹 Cleaning SOC Lab..."

aws cloudtrail stop-logging --name SecurityLab-Trail 2>/dev/null
aws cloudtrail delete-trail --name SecurityLab-Trail 2>/dev/null

aws events remove-targets --rule Detect-IAM-Security-Changes --ids "1" 2>/dev/null
aws events delete-rule --name Detect-IAM-Security-Changes 2>/dev/null

aws lambda delete-function --function-name SOC-Alert-Handler 2>/dev/null

aws sns delete-topic --topic-arn $(cat sns-topic-arn.txt) 2>/dev/null

aws s3 rb s3://$(cat bucket-name.txt) --force 2>/dev/null

echo "✅ Cleanup done"
