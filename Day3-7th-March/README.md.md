================================================================
          DAILY SCRIPTING & PRACTICAL SUMMARY (LINUX)
================================================================

--- 1. CHECK MAIN DISK USAGE ---
# Command to check how full your main hard drive (Root) is.
# -h : Human readable (GB instead of bytes)
# /  : The Main (Root) disk
Command: df -h /


--- 2. AUTOMATIC FILE CLEANUP SCRIPT ---
# Save as: cleanup.sh
# Description: Deletes .log files older than 7 days in a specific folder.

#!/bin/bash
TARGET_DIR="/tmp/logs"
echo "Cleaning old logs in $TARGET_DIR..."
# find: search the folder
# -name: look for .log files
# -mtime +7: older than 7 days
# -delete: remove them
find "$TARGET_DIR" -name "*.log" -mtime +7 -delete
echo "Done."


--- 3. AUTOMATED HOURLY LOGGING (CRON) ---
# Part A: The Script (Save as: make_log.sh)
# Description: Creates a timestamped file inside /tmp/logs every time it runs.

#!/bin/bash
# 1. Get current time
time=$(date +%Y-%m-%d_%H-%M)
# 2. Ensure folder exists (fixes "No such file" error)
mkdir -p /tmp/logs
# 3. Create the file
touch "/tmp/logs/log_$time.txt"

# Part B: The Schedule (Crontab)
# Run 'crontab -e' and add this line to run it every hour:
0 * * * * /home/milanrouth43/make_log.sh


--- 4. GITHUB PROJECT UPDATE SCRIPT ---
# Save as: update_code.sh
# Description: Navigate to project folder and pull latest code.

#!/bin/bash
FOLDER="/home/milanrouth43/MyScripts/X-Tic-Tac-Toe"
echo "Updating Project..."
# Go to folder (stop if not found)
cd "$FOLDER" || exit
# Pull changes
git pull origin main
echo "Update Complete."


--- 5. WEB DEPLOYMENT SCRIPT ---
# Save as: deploy.sh
# Description: Pulls code AND restarts the Nginx web server.

#!/bin/bash
FOLDER="/home/milanrouth43/MyScripts/X-Tic-Tac-Toe"
SERVICE="nginx"

echo "Deploying..."
cd "$FOLDER" || exit
git pull origin main
# Sudo is needed to restart system services
sudo systemctl restart "$SERVICE"
echo "Deployed & Restarted."


--- 6. RUN LOCAL PYTHON WEB SERVER ---
# Save as: run_game.sh
# Description: Instantly host your static HTML/JS project on localhost:8000.

#!/bin/bash
cd ~/MyScripts/X-Tic-Tac-Toe
echo "Starting server at http://localhost:8000..."
python3 -m http.server 8000


--- 7. FIND HUMAN USERS ---
# Save as: list_humans.sh
# Description: Lists all real users (UID >= 1000), ignoring system users.

#!/bin/bash
echo "Real Humans on this System:"
# UID 1000 is the starting ID for real people in Ubuntu
awk -F: '$3 >= 1000 {print $1}' /etc/passwd


--- 8. PRACTICAL TASK: CREATE, LOG, & SEARCH ---
# Save as: task.sh
# Description: 1) Create a file 'error', 2) Log it, 3) Search for it.

#!/bin/bash
echo "--- Step 1: Create File ---"
touch error

echo "--- Step 2: Create Log ---"
echo "System Alert: The file error has been detected." > error.log

echo "--- Step 3: Search Log ---"
# grep searches for the word "error" inside "error.log"
grep "error" error.log

echo "--- Step 4: Locate File ---"
# Shows the full path of the file
echo "File location: $(pwd)/error"