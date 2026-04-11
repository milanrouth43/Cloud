#!/bin/bash

echo "🔍 COMPLIANCE LAB VALIDATION"
echo "============================"

SCORE=0

if aws configservice describe-configuration-recorders | grep default > /dev/null; then
  echo "✅ Config Recorder exists"
  SCORE=$((SCORE+1))
else
  echo "❌ Config Recorder missing"
fi

if aws configservice describe-delivery-channels | grep name > /dev/null; then
  echo "✅ Delivery Channel exists"
  SCORE=$((SCORE+1))
else
  echo "❌ Delivery Channel missing"
fi

if aws configservice describe-config-rules | grep S3-Bucket-Public-Read-Prohibited > /dev/null; then
  echo "✅ Config Rule exists"
  SCORE=$((SCORE+1))
else
  echo "❌ Config Rule missing"
fi

if aws configservice get-compliance-details-by-config-rule   --config-rule-name S3-Bucket-Public-Read-Prohibited   | grep NON_COMPLIANT > /dev/null; then
  echo "✅ Non-compliant bucket detected"
  SCORE=$((SCORE+1))
else
  echo "❌ No non-compliant bucket detected"
fi

echo ""
echo "Result: $SCORE/4 checks passed"
