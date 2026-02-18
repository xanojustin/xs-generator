# AWS S3 File Operations Run Job

This Xano Run Job provides a complete solution for managing files in AWS S3 buckets. It supports listing, uploading, reading, generating signed URLs, and deleting files.

## Features

- **List Files**: List all files in a bucket with optional prefix filtering
- **Upload Files**: Upload new files to S3 with automatic content handling
- **Read Files**: Retrieve file contents from S3
- **Generate Signed URLs**: Create temporary access URLs for private files
- **Delete Files**: Remove files from S3 buckets
- **Combined Operation**: List existing files and upload a test file in one operation
- **Operation Logging**: All operations are logged to a database table for audit purposes

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `AWS_ACCESS_KEY_ID` | Your AWS Access Key ID | Yes |
| `AWS_SECRET_ACCESS_KEY` | Your AWS Secret Access Key | Yes |
| `AWS_REGION` | AWS Region (e.g., us-east-1) | No (defaults to us-east-1) |
| `AWS_S3_BUCKET` | Default S3 bucket name | No (can be provided via input) |

## Operations

### 1. List Files

Lists files in the S3 bucket with optional prefix filtering.

```json
{
  "operation": "list",
  "bucket": "my-bucket",
  "prefix": "uploads/"
}
```

### 2. Upload File

Uploads a file to S3.

```json
{
  "operation": "upload",
  "bucket": "my-bucket",
  "file_key": "documents/report.pdf",
  "file_data": "file content here"
}
```

### 3. Read File

Retrieves file contents from S3.

```json
{
  "operation": "read",
  "bucket": "my-bucket",
  "file_key": "documents/report.pdf"
}
```

### 4. Generate Signed URL

Creates a temporary URL for accessing private files.

```json
{
  "operation": "sign_url",
  "bucket": "my-bucket",
  "file_key": "documents/report.pdf"
}
```

### 5. Delete File

Removes a file from S3.

```json
{
  "operation": "delete",
  "bucket": "my-bucket",
  "file_key": "documents/old-report.pdf"
}
```

### 6. List and Upload (Default)

Lists existing files and uploads a test file with a signed URL.

```json
{
  "operation": "list_and_upload",
  "bucket": "my-bucket",
  "prefix": "uploads/"
}
```

## Response Format

Each operation returns a JSON object with operation-specific details:

```json
{
  "operation": "list_and_upload",
  "bucket": "my-bucket",
  "prefix": "uploads/",
  "existing_files": 5,
  "uploaded_file": {
    "key": "uploads/test-upload-20250218000000.txt",
    "etag": "\"abc123...\"",
    "signed_url": "https://...",
    "expires_in": 3600
  },
  "message": "Listed existing files and uploaded test file successfully"
}
```

## File Structure

```
aws-s3-file-operations/
├── run.xs              # Run job configuration
├── function/
│   └── s3_file_manager.xs  # Main function with S3 operations
├── table/
│   └── file_log.xs     # Audit log table
└── README.md           # This file
```

## Security Notes

- Never commit AWS credentials to version control
- Use environment variables for all sensitive data
- Signed URLs expire after 1 hour by default
- The run job validates all inputs before making S3 API calls

## AWS IAM Permissions Required

Your AWS credentials need the following S3 permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": [
        "arn:aws:s3:::your-bucket-name",
        "arn:aws:s3:::your-bucket-name/*"
      ]
    }
  ]
}
```

## Usage with Xano Run

Deploy and run this job using the Xano CLI or Run API:

```bash
# Deploy the job
xano run deploy ./aws-s3-file-operations

# Execute the job
xano run execute aws-s3-file-operations
```

## Error Handling

The job includes comprehensive error handling:
- Validates required inputs before S3 operations
- Returns clear error messages for missing credentials
- Handles AWS API errors gracefully
- Logs all operations for debugging

## License

MIT
