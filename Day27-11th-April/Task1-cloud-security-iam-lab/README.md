# IAM Least Privilege Practical

This package contains the core files used in the practical:

- `s3-read-only.json` — IAM policy that allows S3 list/read access
- `validate-lab.sh` — validation script to check the lab resources
- `cleanup-lab.sh` — cleanup script to remove created resources

## Generated at runtime
These files are created during the lab and are not committed with values inside:

- `user-name.txt`
- `user-output.json`
- `policy-arn.txt`
- `user-creds.json`
- `bucket-name.txt`

## Typical flow

1. Create IAM user
2. Create policy
3. Attach policy
4. Create access key
5. Create S3 bucket
6. Run validation
7. Run cleanup
8. Run validation again to see failed checks
