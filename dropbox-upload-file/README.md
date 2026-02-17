# Dropbox Upload File - Xano Run Job

Upload files to Dropbox using the Xano Job Runner.

## What This Run Job Does

This run job uploads a file to a specified Dropbox folder using the Dropbox API. It demonstrates:
- Making authenticated API requests to Dropbox
- Uploading file content via the `/files/upload` endpoint
- Handling API responses and error conditions

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `DROPBOX_ACCESS_TOKEN` | Your Dropbox API access token (get from Dropbox App Console) |

## How to Use

1. Set the `DROPBOX_ACCESS_TOKEN` environment variable in your Xano workspace
2. The run job will upload a test file to `/test-folder/test-file.txt`
3. Modify the `input` in `run.xs` to customize the file path and content

## Getting a Dropbox Access Token

1. Go to [Dropbox App Console](https://www.dropbox.com/developers/apps)
2. Create a new app or use an existing one
3. Generate an access token under the "OAuth 2" section
4. Copy the token and set it as `DROPBOX_ACCESS_TOKEN`

## Customizing the Upload

Edit the `input` section in `run.xs`:

```xs
input: {
  file_path: "/your-folder/your-file.txt"  // Destination path in Dropbox
  file_content: "Your file content here"     // Content to upload
}
```

## API Reference

- Dropbox API Documentation: https://www.dropbox.com/developers/documentation
- Files Upload endpoint: https://content.dropboxapi.com/2/files/upload
