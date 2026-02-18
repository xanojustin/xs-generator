# Auth0 Create User Run Job

This Xano Run Job creates a new user in Auth0 using the Management API.

## What It Does

Creates a new user in Auth0 with:
- Email and password authentication
- Optional email verification
- Custom user metadata
- Custom app metadata (read-only in client contexts)

## Prerequisites

1. An Auth0 account with a tenant
2. A Management API token with `create:users` scope
3. The Auth0 domain (e.g., `your-tenant.auth0.com`)

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `AUTH0_DOMAIN` | Your Auth0 tenant domain | `your-tenant.auth0.com` |
| `AUTH0_MANAGEMENT_TOKEN` | Auth0 Management API token | `eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...` |

### Getting a Management API Token

1. Go to Auth0 Dashboard → Applications → APIs
2. Select "Auth0 Management API"
3. Go to "Test" tab
4. Select your application and click "Get Token"
5. Copy the access token

Or programmatically:
```bash
curl --request POST \
  --url https://YOUR_DOMAIN/oauth/token \
  --header 'content-type: application/json' \
  --data '{
    "client_id": "YOUR_CLIENT_ID",
    "client_secret": "YOUR_CLIENT_SECRET",
    "audience": "https://YOUR_DOMAIN/api/v2/",
    "grant_type": "client_credentials"
  }'
```

## File Structure

```
auth0-create-user/
├── run.xs                    # Run job configuration
├── function/
│   └── create_auth0_user.xs  # Function that calls Auth0 API
└── README.md                 # This file
```

## Usage

### Running the Job

```bash
# Using Xano CLI
xano run --job auth0-create-user

# Or with custom input
xano run --job auth0-create-user --input '{
  "email": "john.doe@example.com",
  "password": "SecurePass123!",
  "user_metadata": {
    "first_name": "John",
    "last_name": "Doe"
  }
}'
```

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `email` | email | Yes | - | User's email address |
| `password` | text | Yes | - | User's password |
| `connection` | text | No | `Username-Password-Authentication` | Auth0 database connection |
| `verify_email` | bool | No | `true` | Send verification email |
| `user_metadata` | json | No | `{}` | Custom user metadata |
| `app_metadata` | json | No | `{}` | App-specific metadata |

### Response

```json
{
  "success": true,
  "user_id": "auth0|abc123def456",
  "email": "newuser@example.com",
  "email_verified": false,
  "created_at": "2025-02-18T13:45:30.123Z",
  "connection": "Username-Password-Authentication",
  "user_metadata": {
    "first_name": "New",
    "last_name": "User",
    "signup_source": "xano_run_job"
  },
  "app_metadata": {
    "plan": "free",
    "roles": ["user"]
  }
}
```

## Security Notes

- Never commit your Management API token to version control
- Use environment variables for all sensitive credentials
- The Management API token should have minimal required scopes
- Consider using short-lived tokens rotated regularly
- Passwords are transmitted securely via HTTPS

## Error Handling

The function validates:
- Environment variables are set
- Auth0 API returns success (200/201)
- Provides detailed error messages on failure

## Customization

To modify default values, edit `run.xs`:

```xs
run.job "Auth0 Create User" {
  main = {
    name: "create_auth0_user"
    input: {
      email: "your-default@example.com"
      password: "YourDefaultPass!"
      // ... customize as needed
    }
  }
}
```

## Auth0 Documentation

- [Auth0 Management API - Create User](https://auth0.com/docs/api/management/v2/users/post-users)
- [Auth0 Management API Tokens](https://auth0.com/docs/secure/tokens/management-api-tokens)
- [User Metadata](https://auth0.com/docs/manage-users/user-accounts/metadata)
