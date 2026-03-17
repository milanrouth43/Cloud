AWS VPC ARCHITECTURE PRACTICAL: MASTER STEP-BY-STEP GUIDE

--- PHASE 1: NETWORKING SETUP ---

Step 1: Create the VPC (The Network)
1. Go to VPC Dashboard -> Your VPCs -> Create VPC.
2. Name tag: My-Lab-VPC
3. IPv4 CIDR block: 10.0.0.0/16
4. Tenancy: Default.
5. Click "Create VPC".

Step 2: Create Subnets (The Rooms)
1. Go to VPC Dashboard -> Subnets -> Create subnet.
2. VPC ID: Select "My-Lab-VPC".
3. Subnet 1 (Public):
   - Name: Public-Subnet
   - Availability Zone: us-east-1a
   - IPv4 CIDR block: 10.0.1.0/24
4. Subnet 2 (Private):
   - Click "Add new subnet"
   - Name: Private-Subnet
   - Availability Zone: us-east-1a (Same zone as public)
   - IPv4 CIDR block: 10.0.2.0/24
5. Click "Create subnet".

Step 3: Create Internet Gateway (The Front Door)
1. Go to VPC Dashboard -> Internet gateways -> Create internet gateway.
2. Name tag: My-IGW
3. Click "Create internet gateway".
4. Click "Actions" -> "Attach to VPC".
5. Select "My-Lab-VPC" and click "Attach internet gateway".

Step 4: Create NAT Gateway (The Secure Mail Chute)
** Cost Warning: Delete this immediately after finishing the lab. **
1. Go to VPC Dashboard -> NAT gateways -> Create NAT gateway.
2. Name: My-NAT-GW
3. Subnet: Select "Public-Subnet" (CRITICAL: Must be Public).
4. Elastic IP allocation: Click "Allocate Elastic IP".
5. Click "Create NAT gateway".

Step 5: Configure Route Tables (The Maps)

   A. Public Route Table:
   1. Go to VPC Dashboard -> Route tables.
   2. Find the Main table (auto-created with VPC). Rename it "Public-RT".
   3. Select "Public-RT" -> "Routes" tab -> "Edit routes".
   4. Click "Add route".
      - Destination: 0.0.0.0/0
      - Target: Internet Gateway -> Select "My-IGW".
   5. Click "Save changes".
   6. Go to "Subnet associations" tab -> "Edit subnet associations".
   7. Select "Public-Subnet".
   8. Click "Save associations".

   B. Private Route Table:
   1. Click "Create route table".
   2. Name: Private-RT
   3. VPC: My-Lab-VPC
   4. Click "Create route table".
   5. Select "Private-RT" -> "Routes" tab -> "Edit routes".
   6. Click "Add route".
      - Destination: 0.0.0.0/0
      - Target: NAT Gateway -> Select "My-NAT-GW".
   7. Click "Save changes".
   8. Go to "Subnet associations" tab -> "Edit subnet associations".
   9. Select "Private-Subnet".
   10. Click "Save associations".

--- PHASE 2: SECURITY & SERVERS ---

Step 6: Create Security Group (The Firewall)
1. Go to EC2 Dashboard -> Security Groups -> Create security group.
2. Name: Web-SSH-Access
3. Description: Allow SSH and Ping
4. VPC: Select "My-Lab-VPC".
5. Inbound rules:
   - Rule 1: Type: SSH | Source: Anywhere-IPv4 (0.0.0.0/0)
   - Rule 2: Type: All ICMP - IPv4 | Source: 10.0.0.0/16
6. Click "Create security group".

Step 7: Launch Instances

   Instance A: Public Jump Server (Bastion)
   1. Go to EC2 Dashboard -> Instances -> Launch instances.
   2. Name: Public-Instance
   3. OS: Amazon Linux 2023
   4. Instance Type: t2.micro
   5. Key Pair: Create new "MyLabKey" (Download the .pem file).
   6. Network Settings (Edit):
      - VPC: My-Lab-VPC
      - Subnet: Public-Subnet
      - Auto-assign Public IP: ENABLE (Select "Enable")
      - Security Group: Select "Web-SSH-Access".
   7. Click "Launch instance".

   Instance B: Private Server
   8. Go to EC2 Dashboard -> Instances -> Launch instances.
   9. Name: Private-Instance
   10. OS: Amazon Linux 2023
   11. Instance Type: t2.micro
   12. Key Pair: Select "MyLabKey".
   13. Network Settings (Edit):
      - VPC: My-Lab-VPC
      - Subnet: Private-Subnet
      - Auto-assign Public IP: DISABLE (Select "Disable")
      - Security Group: Select "Web-SSH-Access".
   14. Click "Launch instance".

--- PHASE 3: CONNECTION & TUNNELING ---

Step 8: Connect to Public Instance
1. Open Terminal/PowerShell on your laptop.
2. Navigate to where MyLabKey.pem is (e.g., cd Downloads).
3. Run: ssh -i "MyLabKey.pem" ec2-user@<PUBLIC-IP-OF-INSTANCE-A>
4. Type "yes" to connect.

Step 9: Create Key File Inside Public Instance
1. Open the key file on your laptop with Notepad. Copy ALL text.
2. In the terminal (inside Public Instance), type: nano mykey.pem
3. Paste the text.
4. Press Ctrl+O then Enter (to save).
5. Press Ctrl+X (to exit).
6. Run: chmod 400 mykey.pem

Step 10: Jump to Private Instance
1. Get the Private IP of "Private-Instance" from AWS Console.
2. Run: ssh -i mykey.pem ec2-user@<PRIVATE-IP-OF-INSTANCE-B>
3. Type "yes".

Step 11: Verify Setup
1. Run: ping google.com
2. If it replies, your NAT Gateway and VPC are working perfectly.

--- PHASE 4: CLEANUP (IMPORTANT) ---
1. Terminate both EC2 Instances.
2. Delete NAT Gateway (Wait until status is "Deleted").
3. Release Elastic IP Address.
4. Delete VPC (This removes subnets/routes automatically).