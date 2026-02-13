# Dropbox Create Folder - Xano Run Job

This XanoScript run job creates a folder in Dropbox using the Dropbox API.

## What It Does

The job creates a folder at a specified path in your Dropbox account. If the folder already exists, it gracefully handles the conflict and returns the existing folder information.

## File Structure

```
dropbox-upload-file/
├── run.xs                           # Run job configuration
├── function/
│   └── create_dropbox_folder.xs    # Main folder creation function
└── README.md                        # This file
```

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `dropbox_access_token` | Dropbox OAuth2 access token | Create a Dropbox App at https://www.dropbox.com/developers/apps |

### Getting a Dropbox Access Token

1. Go to https://www.dropbox.com/developers/apps
2. Click "Create app"
3. Choose "Scoped access" and "Full Dropbox" or "App folder"
4. Give your app a name
5. Under the "Permissions" tab, enable `files.content.write` and `files.content.read`
6. Click "Generate" under "Generated access token"
7. Copy the token and set it as `dropbox_access_token` in your Xano environment variables

## How to Use

### Default Usage

By default, the run job creates a folder at `/xano-uploads`:

```
xano run dropbox-upload-file/
```

### Customizing the Folder Path

Edit `run.xs` to change the input parameters:

```xs
run.job "Dropbox Create Folder" {
  main = {
    name: "create_dropbox_folder"
    input: {
      folder_path: "/my-backup-folder/subfolder"
    }
  }
  env = ["dropbox_access_token"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `folder_path` | text | Yes | The folder path to create in Dropbox (e.g., `/backups/2025`) |

## API Reference

This integration uses the Dropbox API:

- **Endpoint**: `POST https://api.dropboxapi.com/2/files/create_folder_v2`
- **Authentication**: OAuth2 Bearer token
- **Documentation**: https://www.dropbox.com/developers/documentation/http/documentation#files-create_folder_v2

## Response

On success, the function returns:

```json
{
  "success": true,
  "message": "Folder created successfully",
  "folder_path": "/xano-uploads",
  "already_existed": false,
  "dropbox_response": {
    "metadata": {
      "name": "xano-uploads",
      "path_lower": "/xano-uploads",
      "path_display": "/xano-uploads",
      "id": "id:...",
      "content_hash": null
    }
  }
}
```

If the folder already exists:

```json
{
  "success": true,
  "message": "Folder already exists",
  "folder_path": "/xano-uploads",
  "already_existed": true,
  ...
}
```

## Error Handling

The function validates inputs and handles API errors:

- Returns `inputerror` if `folder_path` is empty
- Throws error if the Dropbox API returns an unexpected error
- Handles 409 "Conflict" gracefully (folder already exists)
- Logs debug information for troubleshooting

## Security Notes

- Never commit your `dropbox_access_token` to version control
- Use Xano's environment variables for sensitive credentials
- Consider using short-lived access tokens and refresh tokens for production use
- The access token provides access to your Dropbox account - keep it secure

## Extending This Job

You can extend this run job by:
- Adding more functions to list folder contents
- Creating subfolders automatically
- Integrating with other Xano tables for backup workflows
- Adding error notifications via email/Slack
