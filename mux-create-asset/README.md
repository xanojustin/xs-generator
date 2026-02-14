# Mux Create Video Asset - Xano Run Job

This Xano Run Job creates a video asset on [Mux](https://mux.com/) - a powerful video streaming API. It takes a video URL, uploads it to Mux for processing, and returns the asset details including playback IDs.

## What This Run Job Does

1. Accepts a video URL and optional playback policy
2. Authenticates with Mux using Basic Auth (token_id:token_secret)
3. Creates a video asset via Mux's `/video/v1/assets` endpoint
4. Returns the asset ID, playback IDs, and processing status

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `MUX_TOKEN_ID` | Your Mux API access token ID |
| `MUX_TOKEN_SECRET` | Your Mux API access token secret |

## How to Get Mux API Credentials

1. Sign up at [mux.com](https://mux.com/)
2. Go to **Settings > API Access Tokens**
3. Generate a new token with **Full Access** or **Video Read/Write** scope
4. Copy the Token ID and Token Secret

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `video_url` | text | Yes | - | URL to the video file to upload |
| `playback_policy` | text | No | "public" | Playback policy: "public" or "signed" |
| `test_mode` | boolean | No | false | If true, creates a test asset (watermarked, free) |

## Usage

### Basic Usage
```bash
# Set environment variables
export MUX_TOKEN_ID="your_token_id"
export MUX_TOKEN_SECRET="your_token_secret"

# Run the job
xano run --job mux-create-asset
```

### With Custom Input
```bash
xano run --job mux-create-asset --input '{"video_url":"https://mycdn.com/video.mp4","playback_policy":"signed"}'
```

## Response

```json
{
  "success": true,
  "asset_id": "abc123def456",
  "playback_ids": [
    {
      "id": "xyz789",
      "policy": "public"
    }
  ],n  "status": "preparing",
  "created_at": "2026-02-14T22:15:00.000Z",
  "test_mode": false
}
```

## Asset Status Values

- `preparing` - Asset is being processed
- `ready` - Asset is ready for playback
- `errored` - Asset processing failed

## Next Steps

Once the asset status is `ready`, you can use the playback ID to stream the video:

```
https://stream.mux.com/{PLAYBACK_ID}.m3u8
```

## File Structure

```
~/xs/mux-create-asset/
├── run.xs                      # Run job configuration
├── function/
│   └── create_video_asset.xs   # Main function logic
└── README.md                   # This file
```

## API Reference

- [Mux API Documentation](https://docs.mux.com/)
- [Create Asset Endpoint](https://docs.mux.com/api-reference#video/operation/create-asset)
