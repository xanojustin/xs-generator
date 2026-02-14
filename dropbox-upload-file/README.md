# Dropbox Upload File

A Xano run job that uploads files to Dropbox using the Dropbox API.

## What This Run Job Does

This run job uploads a file to a specified path in your Dropbox account. It's useful for:
- Backing up files to Dropbox
- Storing user-generated content
- Archiving documents and images
- Syncing data between systems

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `DROPBOX_ACCESS_TOKEN` | Dropbox OAuth 2 access token | [Dropbox App Console](https://www.dropbox.com/developers/apps) |

### Getting Your Dropbox Access Token

1. Go to https://www.dropbox.com/developers/apps
2. Click "Create app"
3. Choose "Scoped access" and "App folder" or "Full Dropbox"
4. Give your app a name
5. Go to the "Permissions" tab and enable `files.content.write` and `files.content.read`
6. Go to the "Settings" tab and generate an access token
7. Copy the token and set it as `DROPBOX_ACCESS_TOKEN` in your Xano environment variables

## How to Use

### Via Xano Run API

```bash
curl -X POST https://app.dev.xano.com/api:run/v1/run \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_XANO_RUN_TOKEN" \
  -d '{
    "job": "Dropbox Upload File",
    "input": {
      "file_content": "base64-encoded-file-content",
      "dropbox_path": "/uploads/document.pdf",
      "file_name": "document.pdf"
    }
  }'
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `file_content` | text | Yes | Base64-encoded file content |
| `dropbox_path` | text | Yes | Destination path in Dropbox (e.g., `/uploads/file.pdf`) |
| `file_name` | text | Yes | Name of the file |
| `mode` | text | No | Write mode: `add` (default), `overwrite`, or `update` |

### Output

```json
{
  "success": true,
  "file": {
    "name": "document.pdf",
    "path_lower": "/uploads/document.pdf",
    "id": "id:abc123...",
    "size": 12345,
    "server_modified": "2024-01-15T10:30:00Z"
  }
}
```

## File Structure

```
dropbox-upload-file/
├── run.xs              # Run job definition
├── function/
│   └── upload_file.xs  # Upload logic
└── README.md           # This file
```

## Notes

- The Dropbox API has a file size limit of 150 MB for single uploads via this endpoint
- For larger files, use the upload session API (not implemented here)
- Make sure your Dropbox app has the correct permissions enabled
- Access tokens expire periodically; refresh tokens can be used for production apps
