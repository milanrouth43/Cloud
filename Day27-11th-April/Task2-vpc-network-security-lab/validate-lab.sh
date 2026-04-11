#!/bin/bash

echo "🔍 MODULE 2: NETWORK SECURITY VALIDATION"
echo "========================================="

PASS=0
TOTAL=7

# 1. VPC
if [ -f vpc-id.txt ] && aws ec2 describe-vpcs --vpc-ids $(cat vpc-id.txt) &>/dev/null; then
  echo "✅ VPC Exists"; ((PASS++))
else
  echo "❌ VPC Missing"
fi

# 2. Public Subnet
if [ -f public-subnet-id.txt ] && aws ec2 describe-subnets --subnet-ids $(cat public-subnet-id.txt) &>/dev/null; then
  echo "✅ Public Subnet"; ((PASS++))
else
  echo "❌ Public Subnet Missing"
fi

# 3. Internet Gateway
if [ -f igw-id.txt ] && aws ec2 describe-internet-gateways --internet-gateway-ids $(cat igw-id.txt) &>/dev/null; then
  echo "✅ Internet Gateway"; ((PASS++))
else
  echo "❌ IGW Missing"
fi

# 4. Bastion Instance
BASTION=$(cat bastion-id.txt 2>/dev/null)
if [ -n "$BASTION" ] && aws ec2 describe-instances --instance-ids $BASTION --query 'Reservations[0].Instances[0].State.Name' --output text | grep -q "running"; then
  echo "✅ Bastion Running"; ((PASS++))
else
  echo "❌ Bastion Not Running"
fi

# 5. Security Groups
if [ -f bastion-sg-id.txt ] && [ -f private-sg-id.txt ]; then
  echo "✅ Security Groups Configured"; ((PASS++))
else
  echo "❌ Security Groups Missing"
fi

# 6. SSH Test (Bastion)
echo "Testing SSH connectivity..."
if ssh -i vpc-lab-key-2.pem -o ConnectTimeout=8 -o StrictHostKeyChecking=no ec2-user@$(aws ec2 describe-instances --instance-ids $BASTION --query 'Reservations[0].Instances[0].PublicIpAddress' --output text) "echo OK" &>/dev/null; then
  echo "✅ SSH to Bastion works"; ((PASS++))
else
  echo "❌ SSH failed"
fi

# 7. Private Instance Exists
PRIVATE=$(cat private-id.txt 2>/dev/null)
if [ -n "$PRIVATE" ] && aws ec2 describe-instances --instance-ids $PRIVATE &>/dev/null; then
  echo "✅ Private Instance Exists"; ((PASS++))
else
  echo "❌ Private Instance Missing"
fi

echo -e "\n🎯 $PASS/$TOTAL checks PASSED"

if [ "$PASS" -eq "$TOTAL" ]; then
  echo "🎉 All checks passed! Lab is perfect."
else
  echo "⚠️ Some checks failed. Review setup."
fi
