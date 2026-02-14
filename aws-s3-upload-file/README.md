# AWS S3 File Upload Run Job

This XanoScript run job uploads files to Amazon S3 using the AWS Signature Version 4 authentication.

## What It Does

The `aws-s3-upload-file` run job:
1. Takes a file path, content, and content type as input
2. Generates AWS Signature V4 authentication headers
3. Uploads the file to the specified S3 bucket
4. Logs the upload attempt to a local `upload_log` table
5. Returns success/failure status with S3 URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `AWS_ACCESS_KEY_ID` | Your AWS access key ID | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret access key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `AWS_REGION` | AWS region where your bucket is located | `us-east-1` |
| `AWS_S3_BUCKET` | Name of your S3 bucket | `my-bucket-name` |

## How to Use

### Run the Job

```bash
# Using Xano CLI
xano run run.xs
```

### Input Parameters

The job accepts these input parameters:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `file_path` | text | Yes | The path/key for the file in S3 (e.g., `uploads/file.txt`) |
| `file_content` | text | Yes | The content to upload |
| `content_type` | text | No | MIME type of the file (default: `application/octet-stream`) |

### Example Inputs

```json
{
  "file_path": "documents/report.pdf",
  "file_content": "(base64 or raw content)",
  "content_type": "application/pdf"
}
```

### Response

```json
{
  "success": true,
  "file_path": "documents/report.pdf",
  "bucket": "my-bucket-name",
  "region": "us-east-1",
  "s3_url": "https://my-bucket-name.s3.us-east-1.amazonaws.com/documents/report.pdf",
  "status_code": 200,
  "message": "File uploaded successfully to S3",
  "log_id": 42
}
```

## File Structure

```
aws-s3-upload-file/
├── run.xs                    # Run job definition
├── function/
│   └── s3_upload_file.xs     # Main upload function
├── table/
│   └── upload_log.xs         # Upload logging table
└── README.md                 # This file
```

## Notes

- The job uses AWS Signature Version 4 for authentication
- All uploads are logged to the `upload_log` table for auditing
- The S3 bucket must exist and the AWS credentials must have `s3:PutObject` permission
- For binary files, ensure proper encoding is handled before passing to `file_content`

## Security Considerations

- Never commit AWS credentials to version control
- Use environment variables or a secrets manager
- Ensure the IAM user/role has minimal required permissions (principle of least privilege)
- Consider enabling S3 bucket versioning for important files
- Use HTTPS-only bucket policies when possible
