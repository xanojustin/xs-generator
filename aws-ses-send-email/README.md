# AWS SES Send Email Run Job

This Xano Run Job sends emails using Amazon Simple Email Service (AWS SES) API.

## What It Does

This run job:
1. Sends transactional emails via AWS SES v2 API
2. Supports both HTML and plain text email bodies
3. Supports custom "From" name and reply-to addresses
4. Logs all sent emails to a database table for tracking
5. Handles errors gracefully with detailed error messages

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `AWS_ACCESS_KEY_ID` | Your AWS IAM access key ID | `AKIAIOSFODNN7EXAMPLE` |
| `AWS_SECRET_ACCESS_KEY` | Your AWS IAM secret access key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `AWS_REGION` | AWS region where SES is configured | `us-east-1` |

## AWS SES Setup

1. **Verify your sender email/domain** in AWS SES console
2. **Create IAM credentials** with the following permissions:
   - `ses:SendEmail`
   - `ses:SendRawEmail`
3. **If in sandbox mode**: Verify recipient email addresses too

## How to Use

### Basic Usage

```bash
# Run with default parameters (defined in run.xs)
xano run
```

### With Custom Parameters

You can override input parameters when running the job:

```bash
xano run --input '{
  "to_email": "user@example.com",
  "to_name": "John Doe",
  "subject": "Welcome to Our Service",
  "body_text": "Thanks for signing up!",
  "body_html": "<h1>Welcome!</h1><p>Thanks for signing up!</p>",
  "from_email": "noreply@yourdomain.com",
  "from_name": "Your Company"
}'
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_email` | email | Yes | Recipient email address |
| `to_name` | text | No | Recipient display name |
| `subject` | text | Yes | Email subject line |
| `body_text` | text | Yes | Plain text email body |
| `body_html` | text | No | HTML email body (optional) |
| `from_email` | email | Yes | Sender email address (must be verified in SES) |
| `from_name` | text | No | Sender display name |
| `reply_to` | email | No | Reply-to email address |

## File Structure

```
aws-ses-send-email/
├── run.xs                  # Run job configuration
├── function/
│   └── send_email.xs       # Main email sending function
├── table/
│   └── email_log.xs        # Email logging table
└── README.md               # This file
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "message_id": "0100017f2b7c9c4a-8a1b2c3d-4e5f-6g7h-8i9j-0k1l2m3n4o5p",
  "to": "recipient@example.com",
  "logged": true
}
```

## Error Handling

The run job handles common SES errors:
- **400 Bad Request**: Invalid parameters or unverified email
- **403 Forbidden**: Authentication failure (check credentials)
- **Other errors**: Generic error with HTTP status

All attempts (success or failure) are logged to the `email_log` table.

## Moving to Production

1. **Request SES production access** from AWS to remove sending limits
2. **Set up DKIM** for better deliverability
3. **Configure SPF and DMARC** records for your domain
4. **Monitor bounce and complaint rates** in AWS SES console

## Notes

- AWS SES v2 API is used (`email.{region}.amazonaws.com/v2/email/outbound-emails`)
- The job uses AWS Signature Version 4 authentication
- Email addresses must be verified in SES before sending (in sandbox mode)
- Consider using AWS SES configuration sets for tracking opens/clicks
