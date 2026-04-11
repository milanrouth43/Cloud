    #!/bin/bash

    # Load saved names if they exist
    USER=$(cat user-name.txt 2>/dev/null)
    POLICY_ARN=$(cat policy-arn.txt 2>/dev/null)
    BUCKET=$(cat bucket-name.txt 2>/dev/null)

    # Detach and remove IAM policy
    if [ -n "$USER" ] && [ -n "$POLICY_ARN" ]; then
      aws iam detach-user-policy --user-name "$USER" --policy-arn "$POLICY_ARN" 2>/dev/null || true
      aws iam delete-policy --policy-arn "$POLICY_ARN" 2>/dev/null || true
    fi

    # Delete access keys if present in user-creds.json
    if [ -f user-creds.json ]; then
      ACCESS_KEY_ID=$(python3 - <<'PY'
import json
from pathlib import Path
p = Path("user-creds.json")
if p.exists():
    try:
        data = json.loads(p.read_text())
        print(data["AccessKey"]["AccessKeyId"])
    except Exception:
        pass
PY
)
      if [ -n "$ACCESS_KEY_ID" ] && [ -n "$USER" ]; then
        aws iam delete-access-key --access-key-id "$ACCESS_KEY_ID" --user-name "$USER" 2>/dev/null || true
      fi
    fi

    # Delete bucket
    if [ -n "$BUCKET" ]; then
      aws s3 rb "s3://$BUCKET" --force 2>/dev/null || true
    fi

    echo "✅ Cleanup completed."
