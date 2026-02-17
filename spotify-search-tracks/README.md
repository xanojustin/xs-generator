# Spotify Search Tracks - Xano Run Job

A Xano Run Job that searches for tracks using the Spotify Web API.

## What This Run Job Does

This run job connects to the Spotify Web API and searches for music tracks based on a query string. It returns formatted track information including:

- Track name
- Primary artist name
- Album name
- Spotify URL (link to open in Spotify)
- Preview URL (30-second audio preview, if available)
- Duration (in milliseconds)
- Popularity score (0-100)

## Prerequisites

### Spotify Developer Account

1. Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
2. Create a new app or use an existing one
3. Note your Client ID and Client Secret

### Getting an Access Token

Spotify uses OAuth 2.0 for authentication. You have two options:

#### Option 1: Client Credentials Flow (App-only access, no user data)

```bash
curl -X POST "https://accounts.spotify.com/api/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET"
```

#### Option 2: Use the Spotify Web Console

1. Visit [Spotify Web API Console](https://developer.spotify.com/documentation/web-api/reference/search)
2. Click "Try it"
3. Authenticate and copy the access token

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `spotify_access_token` | A valid Spotify OAuth access token |

## How to Use

### Running the Job

```bash
# Set your access token as an environment variable
export spotify_access_token="your_access_token_here"

# Run the job (requires Xano CLI configured)
xano run
```

### Customizing the Search

Edit `run.xs` to change the search parameters:

```xs
run.job "Spotify Search Tracks" {
  main = {
    name: "search_tracks"
    input: {
      query: "Your Search Query Here"  // Change this
      limit: 10                         // Number of results (1-50)
      access_token: $env.spotify_access_token
    }
  }
  env = ["spotify_access_token"]
}
```

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | text | Yes | - | Search query string (song name, artist, etc.) |
| `limit` | int | No | 20 | Maximum number of results (1-50) |
| `access_token` | text | Yes | - | Spotify OAuth access token |

### Response Format

```json
{
  "query": "Never Gonna Give You Up",
  "total_results": 1472,
  "returned_count": 5,
  "tracks": [
    {
      "name": "Never Gonna Give You Up",
      "artist": "Rick Astley",
      "album": "Whenever You Need Somebody",
      "spotify_url": "https://open.spotify.com/track/...",
      "preview_url": "https://p.scdn.co/mp3-preview/...",
      "duration_ms": 213573,
      "popularity": 85
    }
  ]
}
```

## File Structure

```
spotify-search-tracks/
├── run.xs              # Run job configuration
├── function/
│   └── search_tracks.xs  # Main search function
└── README.md           # This file
```

## Spotify API Documentation

- [Spotify Web API Reference - Search](https://developer.spotify.com/documentation/web-api/reference/search)
- [Spotify Web API Authorization Guide](https://developer.spotify.com/documentation/general/guides/authorization/)

## Rate Limits

Spotify applies rate limits to API requests. If you exceed the limit, you'll receive a 429 response. The limits are generally generous for development but scale with your app's user base.

## Notes

- Access tokens expire after 1 hour (3600 seconds) for Client Credentials flow
- Preview URLs are not available for all tracks
- Popularity scores are relative and change over time based on listening patterns
