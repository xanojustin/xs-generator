# Giphy GIF Search Run Job

A Xano Run Job that searches for GIFs using the Giphy API.

## What It Does

This run job searches Giphy's vast library of animated GIFs and returns formatted results with multiple image sizes suitable for different use cases (original, fixed height, fixed width, and preview).

## Folder Structure

```
giphy-search-gifs/
├── run.xs              # Run job configuration
├── function/
│   └── search_gifs.xs  # Main search function
└── README.md           # This file
```

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `giphy_api_key` | Your Giphy API key. Get one at https://developers.giphy.com |

## Input Parameters

The `search_gifs` function accepts these inputs:

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | text | Yes | - | Search query for GIFs |
| `limit` | int | No | 10 | Max results (1-50) |
| `rating` | text | No | "g" | Content rating: g, pg, pg-13, r |
| `lang` | text | No | "en" | Language code (ISO 639-1) |

## Response Format

```json
{
  "query": "funny cats",
  "total_count": 12500,
  "count": 5,
  "gifs": [
    {
      "id": "abc123",
      "title": "Funny Cat GIF",
      "url": "https://giphy.com/gifs/abc123",
      "embed_url": "https://giphy.com/embed/abc123",
      "images": {
        "original": "https://media.giphy.com/media/abc123/giphy.gif",
        "fixed_height": "https://media.giphy.com/media/abc123/200.gif",
        "fixed_width": "https://media.giphy.com/media/abc123/200w.gif",
        "preview": "https://media.giphy.com/media/abc123/giphy-preview.gif"
      },
      "user": {
        "username": "catlover",
        "display_name": "Cat Lover",
        "avatar_url": "https://..."
      }
    }
  ]
}
```

## How to Use

### Running the Job

```bash
# Set your API key
export giphy_api_key="your_api_key_here"

# Run the job
xano run execute ./giphy-search-gifs
```

### Modifying the Search

Edit `run.xs` to change the default search:

```xs
run.job "Giphy GIF Search" {
  main = {
    name: "search_gifs"
    input: {
      query: "celebration"     // Change this
      limit: 10                // Change this
      rating: "pg"             // Change this
      lang: "en"
    }
  }
  env = ["giphy_api_key"]
}
```

## API Documentation

- Giphy Search API: https://developers.giphy.com/docs/api/endpoint#search
- Get an API Key: https://developers.giphy.com/dashboard/

## Content Ratings

| Rating | Description |
|--------|-------------|
| `g` | Suitable for all audiences (default) |
| `pg` | Parental guidance suggested |
| `pg-13` | Parents strongly cautioned |
| `r` | Restricted |

## Use Cases

- Add GIF search to chat applications
- Enhance social media posts with animated content
- Build a GIF picker for content creation tools
- Create fun interactive experiences
