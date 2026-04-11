#!/bin/bash

echo "🔍 IAM LAB VALIDATION"
echo "====================="

PASS=0
TOTAL=4

# 1. IAM User
if [ -f user-name.txt ] && aws iam get-user --user-name $(cat user-name.txt) &>/dev/null; then
  echo "✅ IAM User exists"; ((PASS++))
else
  echo "❌ IAM User missing"
fi

# 2. Policy
if [ -f user-name.txt ] && aws iam list-attached-user-policies --user-name $(cat user-name.txt) | grep -q S3ReadOnly; then
  echo "✅ Policy attached"; ((PASS++))
else
  echo "❌ Policy attached"
fi

# 3. Access Key
if [ -f user-creds.json ]; then
  echo "✅ Access key exists"; ((PASS++))
else
  echo "❌ Access key missing"
fi

# 4. Bucket
if [ -f bucket-name.txt ] && aws s3 ls s3://$(cat bucket-name.txt) &>/dev/null; then
  echo "✅ Bucket access works"; ((PASS++))
else
  echo "❌ Bucket access failed"
fi

echo "Result: $PASS/$TOTAL checks passed"
