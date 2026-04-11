#!/bin/bash
echo "🔍 MODULE 3: DATA SECURITY VALIDATION"
echo "====================================="

PASS=0
TOTAL=4

# 1. Encrypted Bucket
if [ -f bucket-name.txt ]; then
    BUCKET=$(cat bucket-name.txt)
    if aws s3api get-bucket-encryption --bucket "$BUCKET" &>/dev/null; then
        echo "✅ S3 Bucket with SSE-KMS"
        ((PASS++))
    else
        echo "❌ Bucket encryption missing"
    fi
else
    echo "❌ bucket-name.txt not found"
fi

# 2. File uploaded
if [ -n "$BUCKET" ] && aws s3 ls s3://"$BUCKET"/secret-data.txt &>/dev/null; then
    echo "✅ Sensitive file uploaded"
    ((PASS++))
else
    echo "❌ File missing"
fi

# 3. SSM Parameters
if aws ssm get-parameters-by-path         --path "/prod/"         --recursive         --query 'Parameters[0]' &>/dev/null; then
    echo "✅ SecureString Parameters stored"
    ((PASS++))
else
    echo "❌ SSM Parameters missing"
fi

# 4. Decryption
if aws ssm get-parameter         --name "/prod/db/password"         --with-decryption &>/dev/null; then
    echo "✅ Secrets can be decrypted"
    ((PASS++))
else
    echo "❌ Decryption failed"
fi

echo -e "\n🎯 $PASS/$TOTAL checks PASSED"

if [ "$PASS" -eq "$TOTAL" ]; then
    echo "🎉 All checks passed!"
else
    echo "⚠️ Fix issues before cleanup"
fi
