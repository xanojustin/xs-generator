# Firebase Create User Run Job

This Xano Run Job creates a new user in Firebase Authentication using the Firebase Auth REST API.

## What It Does

The run job creates a Firebase Auth user with:
- Email and password authentication
- Optional display name
- Returns user credentials and tokens

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `FIREBASE_API_KEY` | Your Firebase project API key | Firebase Console → Project Settings → General → Web API Key |
| `FIREBASE_PROJECT_ID` | Your Firebase project ID | Firebase Console → Project Settings → General → Project ID |

## File Structure

```
firebase-create-user/
├── run.xs                          # Run job configuration
├── function/
│   └── create_firebase_user.xs     # Main function logic
└── README.md                       # This file
```

## How to Use

### 1. Set Environment Variables

In your Xano workspace, set these environment variables:
- `FIREBASE_API_KEY` - Found in Firebase Console
- `FIREBASE_PROJECT_ID` - Your Firebase project identifier

### 2. Run the Job

The run job will execute the `create_firebase_user` function with default test values:

```bash
# Using Xano CLI
xano run execute firebase-create-user
```

### 3. Customize Input

To customize the user being created, modify the `input` block in `run.xs`:

```xs
run.job "Firebase Create User" {
  main = {
    name: "create_firebase_user"
    input: {
      email: "myuser@mydomain.com"
      password: "MySecurePassword123!"
      display_name: "John Doe"
      email_verified: false
    }
  }
  env = ["FIREBASE_API_KEY", "FIREBASE_PROJECT_ID"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | email | Yes | User's email address (auto-lowercased) |
| `password` | text | Yes | User's password (min 6 characters) |
| `display_name` | text | No | Optional display name for the user |
| `email_verified` | boolean | No | Whether email is pre-verified (default: false) |

## Response

On success, returns:

```json
{
  "success": true,
  "user": {
    "local_id": "abc123xyz",
    "email": "user@example.com",
    "display_name": "John Doe",
    "email_verified": false,
    "created_at": "2025-01-15T10:30:00Z"
  },
  "tokens": {
    "id_token": "eyJhbGciOiJSUzI1...",
    "refresh_token": "AEu4IL2...",
    "expires_in": "3600"
  }
}
```

## Error Handling

The function handles the following error cases:

- **Password too short**: Returns `inputerror` if password < 6 characters
- **Firebase API errors**: Returns `FirebaseAPIError` with message from Firebase
- **Network/timeout errors**: Returns `standard` error type

## Firebase Auth REST API Reference

This implementation uses the Firebase Auth REST API:
- Sign up endpoint: `https://identitytoolkit.googleapis.com/v1/accounts:signUp`
- Update profile endpoint: `https://identitytoolkit.googleapis.com/v1/accounts:update`

Documentation: https://firebase.google.com/docs/reference/rest/auth

## Security Notes

- Never hardcode API keys in your code - always use environment variables
- Store refresh tokens securely
- Consider implementing additional validation before creating users
- Firebase Auth free tier allows 10,000 new users per month
