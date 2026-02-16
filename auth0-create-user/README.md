# Auth0 Create User

A Xano Run Job that creates users in Auth0, a popular identity management platform.

## What This Run Job Does

This run job creates a new user in your Auth0 tenant. It:

1. Obtains an access token from Auth0 using client credentials
2. Creates a new user with email, password, and optional metadata
3. Returns the created user object from Auth0

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `auth0_domain` | Your Auth0 tenant domain (e.g., `your-tenant.auth0.com`) |
| `auth0_client_id` | Your Auth0 application client ID |
| `auth0_client_secret` | Your Auth0 application client secret |

## Auth0 Setup

1. Create an Auth0 account at https://auth0.com
2. Create a new Application (Machine to Machine)
3. Authorize the application to use the Auth0 Management API
4. Grant these permissions:
   - `create:users`
   - `read:users`
5. Copy the Domain, Client ID, and Client Secret to your environment variables

## How to Use

### Basic Usage

Run the job with default settings:

```bash
xano run
```

### With Custom Input

Override the default input values:

```bash
xano run --input '{"email": "newuser@example.com", "password": "MySecurePass123!"}'
```

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `email` | text | Yes | `user@example.com` | User's email address |
| `password` | text | Yes | `SecurePassword123!` | User's password |
| `connection` | text | No | `Username-Password-Authentication` | Auth0 connection name |
| `user_metadata` | json | No | `{}` | Custom user metadata |
| `app_metadata` | json | No | `{}` | Custom app metadata |

## Example Response

```json
{
  "user_id": "auth0|1234567890abcdef",
  "email": "user@example.com",
  "email_verified": false,
  "identities": [
    {
      "connection": "Username-Password-Authentication",
      "user_id": "1234567890abcdef",
      "provider": "auth0",
      "isSocial": false
    }
  ],
  "created_at": "2024-01-15T10:30:00.000Z",
  "updated_at": "2024-01-15T10:30:00.000Z"
}
```

## Files

- `run.xs` - Run job configuration
- `function/create_auth0_user.xs` - Function to create the Auth0 user

## API Reference

This run job uses the Auth0 Management API v2:
- https://auth0.com/docs/api/management/v2/users/post-users
