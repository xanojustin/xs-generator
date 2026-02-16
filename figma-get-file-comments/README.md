# Figma Get File Comments - Xano Run Job

This Xano Run Job fetches comments from a Figma file using the Figma REST API.

## What It Does

Retrieves all comments from a specified Figma file, including:
- Comment text and metadata
- Author information
- Comment locations on the canvas
- Reply threads

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `figma_token` | Figma Personal Access Token | Go to Figma → Settings → Personal Access Tokens |

## How to Use

### 1. Get a Figma File Key

The file key is the string after `/file/` in any Figma URL:
```
https://www.figma.com/file/ABC123DEF456/My-Design-File
                    └───────────────┘
                      This is the key
```

### 2. Run the Job

```bash
# Set your environment variable
export figma_token="your_figma_token_here"

# Run with the file key
xano run run.xs --input '{"file_key": "YOUR_FILE_KEY"}'
```

### 3. Response Format

```json
{
  "file_name": "My Design File",
  "file_key": "ABC123DEF456",
  "comment_count": 5,
  "comments": [
    {
      "id": "123456",
      "message": "Great work on this!",
      "created_at": "2024-01-15T10:30:00Z",
      "user": {
        "handle": "John Doe",
        "email": "john@example.com"
      },
      "client_meta": {
        "node_id": "123:456"
      }
    }
  ]
}
```

## File Structure

```
figma-get-file-comments/
├── run.xs                    # Run job configuration
├── function/
│   └── get_figma_comments.xs # Main function
└── README.md                 # This file
```

## API Reference

Uses the Figma REST API v1:
- Endpoint: `GET /v1/files/{file_key}/comments`
- Documentation: https://www.figma.com/developers/api#get-comments-endpoint

## Common Use Cases

- **Design Review Automation**: Export comments for review tracking
- **Notification Systems**: Check for new comments and alert team members
- **Documentation**: Extract feedback for design system documentation
- **Analytics**: Track comment volume and engagement on designs

## Error Handling

The job validates:
- File key is provided
- Figma token is configured
- API response status is successful

Common errors:
- `401` - Invalid or expired Figma token
- `404` - File not found or no access
- `403` - Insufficient permissions to view comments
