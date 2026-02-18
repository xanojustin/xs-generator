# Mux Create Video Asset

A XanoScript run job that creates video assets using the [Mux](https://mux.com) video API. Mux provides video streaming infrastructure for developers.

## What This Run Job Does

This run job:
1. Takes a video URL and title as input
2. Creates a new video asset in Mux via their REST API
3. Stores the asset metadata in a local database table
4. Returns the asset ID, playback ID, and streaming URLs

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `MUX_TOKEN_ID` | Your Mux access token ID |
| `MUX_TOKEN_SECRET` | Your Mux access token secret |

### Getting Mux Credentials

1. Sign up at [mux.com](https://mux.com)
2. Go to Settings → Access Tokens
3. Create a new token with "Full Access" or "MVP" (video) permissions
4. Copy the Token ID and Token Secret

## Files Structure

```
mux-create-video-asset/
├── run.xs                           # Run job configuration
├── function/
│   └── create_mux_asset.xs          # Main function
├── table/
│   └── video_asset.xs               # Database table
└── README.md                        # This file
```

## Usage

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `video_url` | text | Yes | URL to the video file to ingest |
| `title` | text | Yes | Title for the video asset |

### Response

```json
{
  "success": true,
  "asset_id": "abc123def456",
  "playback_id": "xyz789uvw012",
  "status": "preparing",
  "playback_url": "https://stream.mux.com/xyz789uvw012.m3u8",
  "thumbnail_url": "https://image.mux.com/xyz789uvw012/thumbnail.jpg",
  "database_id": 1
}
```

### Example

```bash
# Set environment variables
export MUX_TOKEN_ID="your-token-id"
export MUX_TOKEN_SECRET="your-token-secret"

# Run the job (via Xano CLI or dashboard)
xano run execute mux-create-video-asset
```

## Mux API Reference

- [Mux API Documentation](https://docs.mux.com/api-reference)
- [Create Asset Endpoint](https://docs.mux.com/api-reference#video/operation/create-asset)

## Notes

- The video asset takes time to process. The initial status will be "preparing".
- Use the `asset_id` to check processing status via Mux's API.
- Playback URLs are HLS (`.m3u8`) format, compatible with most video players.