# Vimeo List Videos - Xano Run Job

This Xano run job fetches and lists videos from a Vimeo account using the Vimeo API.

## What It Does

The run job connects to the Vimeo API and retrieves a paginated list of videos from the authenticated user's account. It supports filtering, sorting, and pagination.

## Features

- **List Videos**: Fetch all videos from your Vimeo account
- **Pagination**: Control page size and navigate through results
- **Filtering**: Search videos by query string
- **Sorting**: Sort by date, name, duration, or modified time
- **Video Details**: Returns comprehensive video metadata including:
  - Video URI and link
  - Title and description
  - Duration, width, height
  - Privacy settings
  - Thumbnail images
  - Upload status

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `VIMEO_ACCESS_TOKEN` | Vimeo API access token | Create at https://developer.vimeo.com/apps |

### Getting a Vimeo Access Token

1. Go to https://developer.vimeo.com/apps
2. Create a new app or select an existing one
3. Navigate to the "Authentication" tab
4. Generate a personal access token with the following scopes:
   - `public` - Access public videos
   - `private` - Access private videos
   - `video_files` - Access video file information

## Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `page` | int | 1 | Page number for pagination |
| `per_page` | int | 10 | Number of videos per page (max 100) |
| `filter` | text | "" | Search query to filter videos |
| `sort` | text | "date" | Sort field: `date`, `alphabetical`, `plays`, `likes`, `comments`, `modified_time`, `duration` |
| `direction` | text | "desc" | Sort direction: `asc` or `desc` |

## Response Structure

```json
{
  "success": true,
  "pagination": {
    "page": 1,
    "per_page": 10,
    "total": 42,
    "total_pages": 5,
    "has_next": true,
    "has_previous": false
  },
  "videos": [
    {
      "uri": "/videos/123456789",
      "name": "My Video Title",
      "description": "Video description",
      "link": "https://vimeo.com/123456789",
      "duration": 120,
      "width": 1920,
      "height": 1080,
      "created_time": "2024-01-15T10:30:00+00:00",
      "modified_time": "2024-01-15T10:35:00+00:00",
      "privacy": "anybody",
      "status": "available",
      "pictures": [...]
    }
  ],
  "count": 10
}
```

## How to Use

### Local Development

1. Set the environment variable:
   ```bash
   export VIMEO_ACCESS_TOKEN="your_token_here"
   ```

2. Run the job:
   ```bash
   xano run execute vimeo-list-videos
   ```

### With Custom Parameters

```bash
xano run execute vimeo-list-videos --input '{"page":1,"per_page":20,"sort":"plays"}'
```

### In Xano Workspace

Deploy this run job to your Xano workspace and trigger it via:
- Xano Scheduler (cron jobs)
- API calls to the Run API
- Manual execution from the Xano dashboard

## API Reference

- **Vimeo API Documentation**: https://developer.vimeo.com/api/reference/videos#get_videos
- **Authentication**: Bearer token via `Authorization: Bearer <token>` header
- **API Version**: 3.4

## Error Handling

The run job handles common error scenarios:
- Invalid access token (401)
- Rate limiting (429)
- Server errors (5xx)

Errors are returned with descriptive messages via the `precondition` validation.

## File Structure

```
vimeo-list-videos/
├── run.xs                     # Run job configuration
├── function/
│   └── fetch_vimeo_videos.xs  # Main function implementation
└── README.md                  # This file
```

## License

MIT - Free to use and modify.
