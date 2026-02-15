# Okta Create User Run Job

A Xano Run Job that creates users in Okta, a leading identity and access management platform.

## What This Run Job Does

This run job creates a new user in your Okta organization via the Okta Users API. It supports:

- Creating users with profile information (first name, last name, email)
- Setting login/username (defaults to email)
- Optional mobile phone number
- Optional password for direct activation
- Proper error handling for common Okta API scenarios

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `OKTA_DOMAIN` | Your Okta domain (without https://) | `dev-123456.okta.com` |
| `OKTA_API_TOKEN` | Your Okta API token (SSWS format) | `00a1b2c3d4...` |

### Getting Your Okta Credentials

1. **Okta Domain**: This is your Okta organization URL. You can find it in your Okta admin console URL or in the top-right corner of your Okta dashboard.

2. **API Token**: 
   - Log in to your Okta admin console
   - Go to **Security** → **API** → **Tokens**
   - Click **Create Token**
   - Give it a name (e.g., "Xano Integration")
   - Copy the token value immediately (it won't be shown again)

## Usage

### Basic Usage

```bash
# Using the Xano CLI
xano run execute --job okta-create-user
```

### With Custom Input

Modify the `run.xs` file to customize the user being created:

```xs
run.job "Okta Create User" {
  main = {
    name: "create_okta_user"
    input: {
      first_name: "Jane"
      last_name: "Smith"
      email: "jane.smith@company.com"
      login: "jane.smith"
      activate: true
      mobile_phone: "+1-555-123-4567"
      password: "TempPassword123!"
    }
  }
  env = ["OKTA_DOMAIN", "OKTA_API_TOKEN"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `first_name` | text | Yes | User's first name |
| `last_name` | text | Yes | User's last name |
| `email` | email | Yes | User's email address |
| `login` | text | No | User's login/username (defaults to email) |
| `activate` | boolean | No | Whether to activate the user immediately (default: true) |
| `mobile_phone` | text | No | User's mobile phone number |
| `password` | text | No | Initial password (if not provided, Okta sends activation email) |

## File Structure

```
okta-create-user/
├── run.xs                      # Run job configuration
├── function/
│   └── create_okta_user.xs     # Main function that calls Okta API
└── README.md                   # This file
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "user_id": "00u1a2b3c4d5e6f7g8h9",
  "status": "ACTIVE",
  "created": "2025-02-14T21:45:00.000Z",
  "activated": "2025-02-14T21:45:00.000Z",
  "profile": {
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com",
    "login": "john.doe@example.com",
    "mobilePhone": null
  },
  "message": "User created successfully"
}
```

## Error Handling

The run job handles these common Okta API errors:

| HTTP Status | Error Type | Description |
|-------------|------------|-------------|
| 400 | ValidationError | Invalid request data |
| 401 | AuthenticationError | Invalid API token or insufficient permissions |
| 409 | ConflictError | User already exists |
| 429 | RateLimitError | API rate limit exceeded |

## Security Notes

- Never commit your `OKTA_API_TOKEN` to version control
- Use Xano's environment variable system to securely store credentials
- The API token grants admin-level access to your Okta organization - protect it accordingly
- Consider using OAuth 2.0 for production applications instead of API tokens

## Okta API Documentation

- [Users API Reference](https://developer.okta.com/docs/reference/api/users/)
- [Create User API](https://developer.okta.com/docs/reference/api/users/#create-user)
- [Authentication](https://developer.okta.com/docs/reference/core-okta-api/#authentication)

## License

MIT
