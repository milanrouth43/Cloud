#!/bin/bash
echo "🧹 Cleaning up..."

BUCKET=$(cat bucket-name.txt 2>/dev/null)

aws s3 rm s3://"$BUCKET" --recursive 2>/dev/null
aws s3 rb s3://"$BUCKET" --force 2>/dev/null

aws ssm delete-parameter --name "/prod/db/password" 2>/dev/null
aws ssm delete-parameter --name "/prod/api/key" 2>/dev/null

rm -f bucket-name.txt secret-data.txt 2>/dev/null

echo "✅ Cleanup done"
