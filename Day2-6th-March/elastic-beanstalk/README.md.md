# AWS Elastic Beanstalk Blue/Green Deployment Practical

## 📌 Objective
To perform a **Blue/Green Deployment** using AWS Elastic Beanstalk. This technique allows us to deploy a new version of a website with **zero downtime** by swapping URLs between two identical environments.

## 🛠️ Prerequisites
1.  **AWS Account** (Free Tier).
2.  **Two Application Versions:**
    * `v1.war` (Displays "Version 1" or "Hello World").
    * `v2.war` (Displays "Version 2" or Updated Content).

---

## 🚀 Step-by-Step Implementation

### Step 1: Create the "Blue" Environment (Original)
1.  Log in to the **AWS Console** and search for **Elastic Beanstalk**.
2.  Click **Create Application**.
3.  **Configuration:**
    * **Name:** `MyPracticalApp`
    * **Platform:** Tomcat (Java)
    * **Application Code:** Upload `v1.war`
    * **Preset:** Single Instance (Free Tier)
4.  **Service Role:** Created/Selected `aws-elasticbeanstalk-service-role`.
5.  **EC2 Profile:** Created/Selected `aws-elasticbeanstalk-ec2-role`.
6.  **Result:** Environment `MyPracticalApp-env` is created and Health is **Green**.
    * *URL Check:* Visiting the URL shows **"Version 1"**.

### Step 2: Create the "Green" Environment (Clone)
1.  Open the dashboard for the **Blue** environment (`MyPracticalApp-env`).
2.  Click **Actions** -> **Clone Environment**.
3.  **URL:** AWS automatically assigns a new temporary URL.
4.  Click **Clone**.
5.  **Result:** A second, identical environment is created.
    * *Blue Environment:* Live traffic (Version 1).
    * *Green Environment:* No traffic (Version 1).

### Step 3: Deploy New Code to "Green"
1.  Open the dashboard for the **Green** (Cloned) environment.
2.  Click **Upload and deploy**.
3.  Select the `v2.war` file.
4.  **Version Label:** `v2`.
5.  Click **Deploy**.
6.  **Result:** The Green environment now runs **Version 2**, while the Blue environment still runs **Version 1**.

### Step 4: Perform the Swap (Blue/Green Switch)
1.  Go to the **Application Overview** page (listing both environments).
2.  Click **Actions** on the **Blue** environment.
3.  Select **Swap Environment URLs**.
4.  Select the **Green** environment from the dropdown.
5.  Click **Swap**.

### Step 5: Verification
1.  Wait 30-60 seconds for the DNS update.
2.  Refresh the **Main (Original) URL**.
3.  **Outcome:** The website now shows **"Version 2"**.
4.  The deployment was successful with zero downtime.

---

## 🧹 Cleanup (To Avoid Costs)
1.  Go to **Elastic Beanstalk Dashboard**.
2.  Select both environments.
3.  Click **Actions** -> **Terminate Environment**.
4.  Confirm termination to stop all EC2 instances.

---

## 📝 Conclusion
Successfully demonstrated a Blue/Green deployment strategy. This ensures that if the new version (Green) has errors, we can instantly swap back to the old version (Blue) without affecting users.