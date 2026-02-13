# Reddit Submit Post Run Job

A XanoScript run job that submits posts to Reddit using the Reddit API.

## What It Does

This run job authenticates with Reddit's OAuth2 API and submits a post to a specified subreddit. It supports:

- **Text Posts (self posts)** - Share thoughts, questions, or discussions
- **Link Posts** - Share external URLs
- **Post Options** - Mark as NSFW or spoiler

Perfect for automated content sharing, cross-posting, or building Reddit bots.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `reddit_client_id` | Your Reddit App's Client ID |
| `reddit_client_secret` | Your Reddit App's Client Secret |
| `reddit_username` | Your Reddit username |
| `reddit_password` | Your Reddit password |

### Getting Reddit API Credentials

1. Go to https://www.reddit.com/prefs/apps
2. Click "create another app..."
3. Select "script" as the app type
4. Name your app (e.g., "XanoScript Bot")
5. Set redirect URI to `http://localhost:8080` (required but not used for script apps)
6. Click "create app"
7. Copy the Client ID (under the app name) and Client Secret

**Security Note:** Keep your credentials secure. Never commit them to version control.

## How to Use

### 1. Set Environment Variables

```bash
export reddit_client_id="your_client_id_here"
export reddit_client_secret="your_client_secret_here"
export reddit_username="your_reddit_username"
export reddit_password="your_reddit_password"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Post

Edit the `input` block in `run.xs` to customize your post:

#### Text Post Example:
```xs
run.job "Reddit Submit Post" {
  main = {
    name: "reddit_submit_post"
    input: {
      subreddit: "webdev"
      title: "What backend tools are you using in 2025?"
      content: "I've been exploring different backend solutions and would love to hear what's working for you. Xano? Supabase? Custom APIs?"
      kind: "self"
      nsfw: false
      spoiler: false
    }
  }
  env = ["reddit_client_id", "reddit_client_secret", "reddit_username", "reddit_password"]
}
```

#### Link Post Example:
```xs
run.job "Reddit Submit Post" {
  main = {
    name: "reddit_submit_post"
    input: {
      subreddit: "technology"
      title: "Interesting article on AI development"
      url: "https://example.com/article"
      kind: "link"
      nsfw: false
      spoiler: false
    }
  }
  env = ["reddit_client_id", "reddit_client_secret", "reddit_username", "reddit_password"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `subreddit` | text | Yes | Subreddit name (without r/ prefix) |
| `title` | text | Yes | Post title (max 300 characters) |
| `content` | text | For self posts | Text content for self posts |
| `url` | text | For link posts | URL to share for link posts |
| `kind` | text | No | Post type: `"self"` (default) or `"link"` |
| `nsfw` | bool | No | Mark as NSFW (default: false) |
| `spoiler` | bool | No | Mark as spoiler (default: false) |

### Post Types

- **self**: Text post with body content (requires `content`)
- **link**: URL post linking to external content (requires `url`)

## File Structure

```
reddit-submit-post/
├── run.xs                              # Run job configuration
├── functions/
│   └── reddit_submit_post.xs           # Function that calls Reddit API
└── README.md                           # This file
```

## API Reference

This implementation uses the Reddit API:

### OAuth2 Authentication
- Endpoint: `POST https://www.reddit.com/api/v1/access_token`
- Documentation: https://www.reddit.com/dev/api/oauth/

### Submit Post
- Endpoint: `POST https://oauth.reddit.com/api/submit`
- Documentation: https://www.reddit.com/dev/api/#POST_api_submit

## Response

On success, the function returns:

```json
{
  "success": true,
  "post_id": "abc123",
  "post_url": "https://www.reddit.com/r/xano/comments/abc123",
  "subreddit": "xano",
  "title": "Just discovered XanoScript...",
  "kind": "self"
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (subreddit, title)
- Title too long (>300 characters)
- Invalid post kind
- Missing content for self posts
- Missing URL for link posts
- Reddit API authentication errors
- Reddit API rate limits
- Subreddit posting restrictions

## Reddit API Limits

Reddit has rate limits for API usage:
- 60 requests per minute for OAuth2 requests
- Posting too frequently may trigger cooldowns
- Some subreddits have karma/age requirements

Always respect Reddit's API terms: https://www.redditinc.com/policies/data-api-terms

## License

MIT
