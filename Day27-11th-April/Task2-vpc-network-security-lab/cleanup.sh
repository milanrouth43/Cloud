#!/bin/bash

echo "🧹 Cleaning up VPC Lab..."

BASTION=$(cat bastion-id.txt 2>/dev/null)
PRIVATE=$(cat private-id.txt 2>/dev/null)
VPC=$(cat vpc-id.txt 2>/dev/null)
IGW=$(cat igw-id.txt 2>/dev/null)

# Terminate instances
aws ec2 terminate-instances --instance-ids $BASTION $PRIVATE 2>/dev/null
aws ec2 wait instance-terminated --instance-ids $BASTION $PRIVATE 2>/dev/null

# Delete security groups
aws ec2 delete-security-group --group-id $(cat bastion-sg-id.txt) 2>/dev/null
aws ec2 delete-security-group --group-id $(cat private-sg-id.txt) 2>/dev/null

# Detach & delete IGW
aws ec2 detach-internet-gateway --vpc-id $VPC --internet-gateway-id $IGW 2>/dev/null
aws ec2 delete-internet-gateway --internet-gateway-id $IGW 2>/dev/null

# Delete subnets
aws ec2 delete-subnet --subnet-id $(cat public-subnet-id.txt) 2>/dev/null
aws ec2 delete-subnet --subnet-id $(cat private-subnet-id.txt) 2>/dev/null

# Delete VPC
aws ec2 delete-vpc --vpc-id $VPC 2>/dev/null

echo "✅ Cleanup completed"
