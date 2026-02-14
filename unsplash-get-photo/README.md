# Unsplash Get Random Photo

This Xano run job fetches a random photo from the Unsplash API based on a search query.

## What It Does

The run job calls the Unsplash `/photos/random` endpoint to retrieve a random photo matching your search criteria. It returns the photo URLs, description, and photographer attribution information.

## Required Environment Variables

- `UNSPLASH_ACCESS_KEY` - Your Unsplash API access key (get one at https://unsplash.com/developers)

## How to Use

### Default Usage
```xs
run.job "Unsplash Get Random Photo" {
  main = {
    name: "get_photo"
    input: {}
  }
  env = ["UNSPLASH_ACCESS_KEY"]
}
```

### With Custom Parameters
```xs
run.job "Unsplash Get Random Photo" {
  main = {
    name: "get_photo"
    input: {
      query: "mountains"
      orientation: "portrait"
    }
  }
  env = ["UNSPLASH_ACCESS_KEY"]
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | text | No | "nature" | Search term for photos |
| `orientation` | text | No | "landscape" | Photo orientation: `landscape`, `portrait`, or `squarish` |

## Response

```json
{
  "success": true,
  "photo_id": "abc123",
  "photo_url": "https://images.unsplash.com/...",
  "photo_thumb": "https://images.unsplash.com/...",
  "description": "Mountain landscape at sunset",
  "alt_description": "snow covered mountain under blue sky",
  "photographer_name": "John Doe",
  "photographer_username": "johndoe",
  "unsplash_link": "https://unsplash.com/photos/...",
  "error": null
}
```

## API Reference

- Unsplash API Documentation: https://unsplash.com/documentation
- Endpoint: `GET /photos/random`

## Files

- `run.xs` - Run job configuration
- `function/get_photo.xs` - Function that calls Unsplash API
