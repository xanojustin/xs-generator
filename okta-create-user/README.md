# Okta Create User Run Job

A Xano Run Job that creates users in Okta using the Okta Users API.

## What It Does

This run job creates a new user in your Okta organization with the following capabilities:

- Creates a user with profile information (first name, last name, email, login)
- Optionally adds mobile phone number
- Handles various error scenarios (validation errors, auth failures, duplicates)
- Returns the created user's ID, status, and metadata

## Prerequisites

- An Okta developer or production account
- An Okta API token with user management permissions
- Your Okta organization URL (e.g., `https://dev-123456.okta.com`)

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `OKTA_API_TOKEN` | Your Okta API token (SSWS format) | `00abc123...xyz` |
| `OKTA_ORG_URL` | Your Okta organization URL | `https://dev-123456.okta.com` |

### Getting Your Okta Credentials

1. **API Token**: 
   - Log in to your Okta admin dashboard
   - Go to Security > API > Tokens
   - Click "Create Token"
   - Copy the token value (it won't be shown again)

2. **Org URL**:
   - Found in your Okta admin URL
   - Format: `https://{your-domain}.okta.com` or `https://{your-domain}.oktapreview.com`

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `first_name` | text | Yes | User's first name |
| `last_name` | text | Yes | User's last name |
| `email` | email | Yes | User's email address |
| `login` | text | Yes | User's unique login identifier (usually same as email) |
| `mobile_phone` | text | No | User's mobile phone number |
| `activate` | bool | No | Whether to activate the user immediately (default: true) |

## Usage

### Running the Job

```bash
# Set environment variables
export OKTA_API_TOKEN="your-api-token"
export OKTA_ORG_URL="https://your-domain.okta.com"

# Run the job (using Xano CLI or Job Runner)
xano run execute run.xs
```

### Example Input

```json
{
  "first_name": "Jane",
  "last_name": "Smith",
  "email": "jane.smith@example.com",
  "login": "jane.smith@example.com",
  "mobile_phone": "+1-555-123-4567",
  "activate": true
}
```

### Example Response

```json
{
  "success": true,
  "user_id": "00u123abc456def789",
  "status": "STAGED",
  "login": "jane.smith@example.com",
  "email": "jane.smith@example.com",
  "created_at": "2024-01-15T10:30:00.000Z",
  "message": "User created successfully in Okta"
}
```

## Error Handling

The job handles the following error scenarios:

| Error | HTTP Status | Description |
|-------|-------------|-------------|
| `OktaValidationError` | 400 | Invalid user data (e.g., malformed email) |
| `OktaAuthError` | 401 | Invalid or expired API token |
| `OktaConflictError` | 409 | User with this login already exists |
| `OktaRateLimitError` | 429 | API rate limit exceeded |
| `OktaAPIError` | Other | Unexpected Okta API errors |

## File Structure

```
~/xs/okta-create-user/
├── run.xs                    # Run job definition
├── function/
│   └── create_okta_user.xs   # User creation function
├── README.md                 # This file
└── FEEDBACK.md               # MCP feedback documentation
```

## API Reference

This job uses the Okta Users API:
- **Endpoint**: `POST /api/v1/users`
- **Documentation**: https://developer.okta.com/docs/reference/api/users/

## Security Notes

- Never commit your `OKTA_API_TOKEN` to version control
- Use environment variables or a secrets manager for production deployments
- The API token should have minimal required permissions (User Administrator role recommended)
- Consider using OAuth 2.0 instead of API tokens for production environments

## License

MIT
