# Sendbird Create User Run Job

This Xano Run Job creates a new user in the Sendbird chat platform.

## What It Does

This run job demonstrates how to create a chat user using Sendbird's Platform API. It includes:

- User ID and nickname validation
- Optional profile image URL support
- Error handling for API failures (400, 401, etc.)
- Environment variable security for API credentials
- Detailed response with user data

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SENDBIRD_API_TOKEN` | Your Sendbird API Token (from Dashboard) |
| `SENDBIRD_APP_ID` | Your Sendbird Application ID |

Get your credentials from: https://dashboard.sendbird.com

## How to Use

### 1. Set Up Environment Variables

```bash
export SENDBIRD_API_TOKEN="your-api-token-here"
export SENDBIRD_APP_ID="your-app-id-here"
```

### 2. Modify the Run Job

Edit `run.xs` to customize the user parameters:

```xs
run.job "Create Sendbird User" {
  main = {
    name: "create_user"
    input: {
      user_id: "unique_user_123"     // Unique identifier for the user
      nickname: "Jane Smith"          // Display name in chat
      profile_url: "https://..."      // Optional: Avatar image URL
    }
  }
  env = ["SENDBIRD_API_TOKEN", "SENDBIRD_APP_ID"]
}
```

### 3. Run the Job

```bash
xano run execute --job "Create Sendbird User"
```

Or use the Run API:

```bash
curl -X POST https://app.dev.xano.com/api:run/v1/run \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "job": "sendbird-create-user",
    "env": {
      "SENDBIRD_API_TOKEN": "your-token",
      "SENDBIRD_APP_ID": "your-app-id"
    }
  }'
```

## Function Reference

### `create_user`

Creates a new user in your Sendbird application.

**Input Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user_id` | text | Yes | Unique identifier for the user (e.g., your database user ID) |
| `nickname` | text | Yes | Display name shown in chat interfaces |
| `profile_url` | text | No | URL to the user's profile/avatar image |

**Response:**

```json
{
  "success": true,
  "user_id": "user_12345",
  "nickname": "John Doe",
  "profile_url": "https://example.com/avatar.jpg",
  "is_active": true,
  "created_at": 1708224000000
}
```

**Error Responses:**

- `400` - Invalid request (duplicate user_id, invalid parameters)
- `401` - Authentication failed (invalid API token)
- `500` - Sendbird server error

## File Structure

```
sendbird-create-user/
├── run.xs              # Run job configuration
├── function/
│   └── create_user.xs  # User creation function
└── README.md           # This file
```

## Customization Ideas

- **Metadata Support**: Extend to include custom metadata fields
- **Batch Creation**: Modify to create multiple users at once
- **Database Integration**: Store created users in a local table
- **Access Token Generation**: Add functionality to generate session tokens
- **User Update**: Create a companion function to update existing users
- **Webhook Handling**: Add webhook endpoint for user events

## Resources

- Sendbird Platform API Docs: https://sendbird.com/docs/chat/platform-api/v3/user
- XanoScript Docs: Use `xanoscript_docs` MCP tool
