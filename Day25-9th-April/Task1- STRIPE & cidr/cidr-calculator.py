#!/usr/bin/env python3
"""
CIDR Calculator & Subnet Planner
Helps students verify network segmentation math
"""
import ipaddress
import sys

def calculate_subnet(cidr, prefix):
    """Calculate subnet details"""
    try:
        network = ipaddress.ip_network(cidr, strict=False)
        subnets = list(network.subnets(new_prefix=prefix))
        return network, subnets
    except ValueError as e:
        return None, str(e)

def main():
    print("🌐 Cloud Network CIDR Calculator")
    print("=" * 40)
    
    if len(sys.argv) < 3:
        print("Usage: python cidr-calculator.py <VPC_CIDR> <SUBNET_PREFIX>")
        print("Example: python cidr-calculator.py 10.0.0.0/16 24")
        sys.exit(1)
    
    vpc_cidr = sys.argv[1]
    try:
        subnet_prefix = int(sys.argv[2])
    except ValueError:
        print("❌ Subnet prefix must be an integer (e.g., 24)")
        sys.exit(1)
    
    network, subnets = calculate_subnet(vpc_cidr, subnet_prefix)
    
    if not network:
        print(f"❌ Invalid CIDR: {subnets}")
        sys.exit(1)
    
    print(f"📦 VPC Network: {network}")
    print(f"🔪 Subnet Mask: /{subnet_prefix}")
    print(f"📊 Total Subnets: {len(subnets)}")
    print(f"💻 Hosts per Subnet: {subnets[0].num_addresses - 2}")
    print("\nFirst 5 Subnets:")
    for i, subnet in enumerate(subnets[:5]):
        print(f"  {i+1}. {subnet} (Range: {subnet.network_address + 1} - {subnet.broadcast_address - 1})")
    
    if len(subnets) > 5:
        print(f"  ... and {len(subnets) - 5} more")

if __name__ == '__main__':
    main()
