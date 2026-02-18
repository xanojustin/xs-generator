# Hunter Email Verification Run Job

This Xano run job verifies email addresses using the Hunter.io Email Verifier API. It checks deliverability, detects disposable emails, validates MX records, and provides a confidence score.

## What It Does

The run job validates email addresses to determine if they are deliverable. This is useful for:

- Email list cleaning and validation
- Preventing fake signups
- Reducing bounce rates
- Detecting disposable/temporary email addresses
- Sales prospecting verification

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `hunter_api_key` | Your Hunter.io API key | Sign up at [hunter.io](https://hunter.io) and get your API key from the dashboard |

## How to Use

### Running the Job

```bash
# Using Xano CLI
xano run execute --job "Hunter Email Verification"

# With custom email
xano run execute --job "Hunter Email Verification" --input '{"email": "user@example.com"}'
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | text | Yes | The email address to verify (e.g., "user@example.com") |

### Example Response

```json
{
  "email": "user@example.com",
  "status": "valid",
  "result": "deliverable",
  "score": 95,
  "regexp": true,
  "gibberish": false,
  "disposable": false,
  "webmail": true,
  "mx_records": true,
  "smtp_server": true,
  "smtp_check": true,
  "accept_all": false,
  "block": false,
  "sources": [],
  "verified_at": "2025-02-18T12:15:00Z"
}
```

## Response Fields Explained

| Field | Description |
|-------|-------------|
| `status` | Validation status: `valid`, `invalid`, or `unknown` |
| `result` | Detailed result: `deliverable`, `undeliverable`, `risky`, or `unknown` |
| `score` | Confidence score from 0-100 |
| `regexp` | Whether the email format is valid |
| `gibberish` | Whether the email appears to be random/gibberish |
| `disposable` | Whether it's a disposable/temporary email address |
| `webmail` | Whether it's a webmail provider (Gmail, Yahoo, etc.) |
| `mx_records` | Whether MX records exist for the domain |
| `smtp_server` | Whether an SMTP server was found |
| `smtp_check` | Whether the SMTP check passed |
| `accept_all` | Whether the domain accepts all emails (catch-all) |
| `block` | Whether the email has been flagged as blocked |

## Error Handling

The run job handles these error cases:

- **400 Bad Request**: Invalid email format
- **401 Unauthorized**: Invalid or missing API key
- **422 Unprocessable**: Validation errors (malformed email)
- **429 Rate Limit**: Too many requests
- **API Errors**: Other Hunter API errors

## File Structure

```
hunter-verify-email/
├── run.xs                 # Run job configuration
├── function/
│   └── verify_email.xs    # Main verification function
└── README.md              # This file
```

## API Reference

- [Hunter Email Verifier API Docs](https://hunter.io/api/docs#email-verifier)
- Rate limits: 100 requests/month on free plan, higher on paid plans

## Use Cases

1. **User Registration**: Verify emails during signup to reduce fake accounts
2. **Email Campaigns**: Clean your mailing list before sending campaigns
3. **Lead Qualification**: Verify prospect emails before outreach
4. **Form Validation**: Real-time email validation on forms
