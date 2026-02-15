# Spotify Search Track

A Xano Run Job that searches for tracks using the Spotify Web API.

## What This Run Job Does

This run job searches for tracks on Spotify using the Spotify Web API's search endpoint. It authenticates using the Client Credentials flow and returns formatted track information including:

- Track ID, name, and Spotify URL
- Artist names
- Album name and cover image
- Track duration (in milliseconds)
- Preview URL (if available)
- Popularity score (0-100)

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SPOTIFY_CLIENT_ID` | Your Spotify App's Client ID from the Spotify Developer Dashboard |
| `SPOTIFY_CLIENT_SECRET` | Your Spotify App's Client Secret from the Spotify Developer Dashboard |

## How to Get Spotify Credentials

1. Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
2. Create a new app or use an existing one
3. Copy the Client ID and Client Secret
4. Set them as environment variables in your Xano workspace

## How to Use

### Default Search
The run job is pre-configured to search for "Never Gonna Give You Up" with 5 results:

```xs
run.job "Spotify Search Track" {
  main = {
    name: "search_track"
    input: {
      query: "Never Gonna Give You Up"
      limit: 5
      market: "US"
    }
  }
  env = ["SPOTIFY_CLIENT_ID", "SPOTIFY_CLIENT_SECRET"]
}
```

### Custom Search Parameters

You can customize the search by modifying the input:

- **query** (required): The search query string (song name, artist, album, etc.)
- **limit** (optional): Maximum number of results (1-50, default: 10)
- **market** (optional): Country code for content restriction (default: US)

### Example: Search for "Bohemian Rhapsody"

```xs
run.job "Spotify Search Track" {
  main = {
    name: "search_track"
    input: {
      query: "Bohemian Rhapsody Queen"
      limit: 3
      market: "US"
    }
  }
  env = ["SPOTIFY_CLIENT_ID", "SPOTIFY_CLIENT_SECRET"]
}
```

## Response Format

```json
{
  "query": "Never Gonna Give You Up",
  "total_results": 150,
  "tracks_returned": 5,
  "tracks": [
    {
      "id": "4uLU6hMCjMI75M1A2tKUQC",
      "name": "Never Gonna Give You Up",
      "artists": ["Rick Astley"],
      "album": "Whenever You Need Somebody",
      "album_image": "https://i.scdn.co/image/...",
      "duration_ms": 213573,
      "preview_url": "https://p.scdn.co/mp3-preview/...",
      "spotify_url": "https://open.spotify.com/track/...",
      "popularity": 85
    }
  ]
}
```

## File Structure

```
spotify-search-track/
├── run.xs                    # Run job configuration
├── function/
│   └── search_track.xs       # Main search function
└── README.md                 # This file
```

## API Reference

This run job uses the [Spotify Web API](https://developer.spotify.com/documentation/web-api):

- **Token Endpoint**: `POST https://accounts.spotify.com/api/token` (Client Credentials flow)
- **Search Endpoint**: `GET https://api.spotify.com/v1/search`

## Notes

- This uses the Client Credentials flow (no user authentication required)
- Search results may vary based on market restrictions
- Preview URLs are not available for all tracks
- Rate limits apply based on your Spotify app quota
