# Reddit Fetch Posts

A Xano Run Job that fetches hot posts from any Reddit subreddit using the Reddit JSON API.

## What This Run Job Does

This run job connects to Reddit's public JSON API to fetch posts from a specified subreddit. It supports multiple sort options (hot, new, top, rising) and returns formatted post data including titles, authors, scores, comment counts, and URLs.

## Features

- Fetch posts from any public subreddit
- Multiple sorting options: hot, new, top, rising
- Configurable post limit (1-100)
- Returns clean, formatted post data
- No authentication required (uses Reddit's public API)

## Required Environment Variables

None! This run job uses Reddit's public JSON API which requires no authentication or API keys.

## Optional Configuration

The run job accepts these input parameters:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `subreddit` | string | `"technology"` | Name of the subreddit (without r/) |
| `sort_by` | string | `"hot"` | Sort order: hot, new, top, rising |
| `limit` | integer | `10` | Number of posts to fetch (max 100) |

## How to Use

### Default Usage

Run with default settings (fetches 10 hot posts from r/technology):

```bash
xano run execute reddit-fetch-posts
```

### Custom Subreddit

To fetch posts from a different subreddit, modify the `input` in `run.xs`:

```xs
run.job "Reddit Fetch Posts" {
  main = {
    name: "fetch_reddit_posts"
    input: {
      subreddit: "programming"
      sort_by: "top"
      limit: 25
    }
  }
}
```

### Using as a Function

You can also call the `fetch_reddit_posts` function directly from other Xano functions:

```xs
function.run "fetch_reddit_posts" {
  input = {
    subreddit: "webdev"
    sort_by: "new"
    limit: 5
  }
} as $posts
```

## Response Format

```json
{
  "subreddit": "technology",
  "sort_by": "hot",
  "total_posts": 10,
  "posts": [
    {
      "id": "abc123",
      "title": "Post Title Here",
      "author": "username",
      "score": 15420,
      "num_comments": 342,
      "url": "https://example.com/article",
      "permalink": "https://reddit.com/r/technology/comments/abc123/post_title",
      "created_utc": 1708000000,
      "subreddit": "technology",
      "is_self": false,
      "selftext": ""
    }
  ]
}
```

## File Structure

```
reddit-fetch-posts/
├── run.xs                    # Run job configuration
├── function/
│   └── fetch_reddit_posts.xs # Main function to fetch posts
└── README.md                 # This file
```

## API Reference

This run job uses Reddit's public JSON API:
- Base URL: `https://www.reddit.com/r/{subreddit}/{sort}.json`
- Documentation: https://www.reddit.com/dev/api/

## Rate Limiting

Reddit's public API has rate limits. For heavy usage, consider:
1. Adding delays between requests
2. Using Reddit's OAuth API with proper authentication
3. Caching results to avoid repeated requests

## Notes

- Only works with public subreddits
- Private/quarantined subreddits will return errors
- Reddit may block requests without a proper User-Agent header (this job includes one)