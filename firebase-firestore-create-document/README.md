# Firebase Firestore Create Document

A Xano Run Job that creates documents in Google Firebase Firestore using the REST API.

## What This Run Job Does

This run job creates a new document in a specified Firestore collection with proper type handling and logging.

### Features

- Creates documents in any Firestore collection
- Automatic type conversion (strings, integers, booleans, arrays, nested objects)
- Logs all operations to a local `firestore_log` table
- Validates inputs and environment variables
- Returns document ID and creation metadata

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `firebase_project_id` | Your Firebase project ID | Firebase Console → Project Settings → General |
| `firebase_auth_token` | Firebase Auth ID token or Service Account token | Generate via Firebase Auth or Service Account JSON |

### Getting a Firebase Auth Token

**Option 1: Using Service Account (Recommended for server-side)**
1. Go to Firebase Console → Project Settings → Service Accounts
2. Click "Generate new private key"
3. Use the JSON credentials to generate a Bearer token via Google's OAuth2

**Option 2: Using Firebase Auth (for testing)**
1. Sign in a user via Firebase Auth
2. Use the user's ID token as the auth token

## How to Use

### Basic Usage

The run job is configured in `run.xs` with default values. You can customize the input:

```xs
run.job "Firebase Firestore Create Document" {
  main = {
    name: "create_firestore_document"
    input: {
      collection: "users"                    // Firestore collection name
      document_data: {                       // Your document data
        name: "John Doe"
        email: "john.doe@example.com"
        role: "admin"
        is_active: true
        tags: ["new", "verified"]
      }
    }
  }
  env = ["firebase_project_id", "firebase_auth_token"]
}
```

### Supported Data Types

The job automatically converts these JavaScript/Xano types to Firestore types:

| Xano Type | Firestore Type | Example |
|-----------|---------------|---------|
| `text` | `stringValue` | `"hello"` |
| `int` | `integerValue` | `42` |
| `bool` | `booleanValue` | `true` |
| `null` | `nullValue` | `null` |
| `array` | `arrayValue` | `[1, 2, 3]` |
| `object` | `mapValue` | `{nested: "data"}` |

### Response

On success, the function returns:

```json
{
  "success": true,
  "document_id": "abc123xyz",
  "collection": "users",
  "document_path": "projects/my-project/databases/(default)/documents/users/abc123xyz",
  "create_time": "2025-01-15T10:30:00.123456Z",
  "log_entry_id": 1
}
```

## File Structure

```
firebase-firestore-create-document/
├── run.xs                                   # Run job configuration
├── function/
│   ├── create_firestore_document.xs         # Main function
│   ├── format_firestore_fields.xs           # Type converter for fields
│   └── format_firestore_array.xs            # Type converter for arrays
├── table/
│   └── firestore_log.xs                     # Operation logging table
└── README.md                                # This file
```

## API Reference

This job uses the Firestore REST API:

```
POST https://firestore.googleapis.com/v1/projects/{project_id}/databases/(default)/documents/{collection}
```

See [Firestore REST API documentation](https://cloud.google.com/firestore/docs/reference/rest) for more details.

## Error Handling

The job validates:
- Environment variables are set
- Collection name is not empty
- Document data is provided
- API response status is successful (2xx)

Errors throw with appropriate error types (`inputerror`, `standard`).

## Security Notes

- Never commit your `firebase_auth_token` to version control
- Use environment variables for all sensitive data
- Consider using Firebase Security Rules to restrict write access
- Service Account tokens are recommended over user tokens for automated jobs

## License

MIT - Part of the XanoScript Run Jobs collection.
