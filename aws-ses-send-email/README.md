# AWS SES Send Email Run Job

This XanoScript run job sends emails using Amazon Web Services Simple Email Service (AWS SES) API.

## What It Does

This run job sends transactional emails via AWS SES. It handles:

- Sending emails to single recipients
- Supporting both plain text and HTML email bodies
- Configurable reply-to addresses
- AWS Signature Version 4 authentication
- Proper error handling and response formatting

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `AWS_ACCESS_KEY_ID` | Your AWS IAM access key ID with SES permissions |
| `AWS_SECRET_ACCESS_KEY` | Your AWS IAM secret access key |
| `AWS_REGION` | AWS region where SES is configured (default: `us-east-1`) |

### AWS IAM Permissions Required

Your AWS IAM user needs the following permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ses:SendEmail",
        "ses:SendRawEmail"
      ],
      "Resource": "*"
    }
  ]
}
```

### SES Identity Verification

Before sending emails, you must verify your sender email address or domain in AWS SES:

1. Go to AWS SES Console → Verified identities
2. Click "Create identity"
3. Choose "Email address" or "Domain"
4. Enter your email/domain and verify ownership

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_email` | text | Yes | Recipient email address |
| `from_email` | text | Yes | Sender email address (must be verified in SES) |
| `subject` | text | Yes | Email subject line |
| `body_text` | text | No | Plain text email body (required if body_html not provided) |
| `body_html` | text | No | HTML email body (required if body_text not provided) |
| `reply_to` | text | No | Reply-to email address |

### Response

```json
{
  "success": true,
  "message_id": "0100017f1234567890abcdef-12345678-1234-1234-1234-123456789012-000000",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "message_id": null,
  "error": "Email address is not verified. The following identities failed the check in region US-EAST-1: sender@example.com"
}
```

## File Structure

```
aws-ses-send-email/
├── run.xs                    # Run job definition
├── function/
│   └── send_email.xs         # Function to send email via SES
├── README.md                 # This file
└── FEEDBACK.md              # MCP/XanoScript feedback
```

## AWS SES API Reference

- [AWS SES v2 API Documentation](https://docs.aws.amazon.com/ses/latest/APIReference-V2/Welcome.html)
- [SendEmail API](https://docs.aws.amazon.com/ses/latest/APIReference-V2/API_SendEmail.html)
- [AWS Signature Version 4](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html)

## Testing

1. Verify a test email address in AWS SES console
2. Set up environment variables with your AWS credentials
3. Update `run.xs` with your verified sender email and test recipient
4. Run the job

### Sandbox Mode

New AWS SES accounts start in sandbox mode with limitations:
- Can only send to verified email addresses
- Maximum 200 emails per 24-hour period
- Maximum 1 email per second

Request production access to remove these limits.

## Security Notes

- Never commit AWS credentials to version control
- Use AWS IAM roles when running in AWS environments (EC2, Lambda, ECS)
- Rotate access keys regularly
- Use least-privilege IAM policies
- Consider using AWS Secrets Manager for credential storage

## Common Issues

| Issue | Solution |
|-------|----------|
| "Email address is not verified" | Verify the sender email in AWS SES console |
| "403 Forbidden" | Check IAM permissions and AWS credentials |
| "Signature does not match" | Ensure system clock is synchronized |
| "Throttling" | You're hitting SES rate limits; implement retry logic |

## Alternative: Using SES SMTP Interface

If you prefer SMTP over the API, you can use Xano's built-in `util.send_email` with SES SMTP credentials instead.
