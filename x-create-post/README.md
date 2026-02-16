# X (Twitter) Create Post Run Job

This Xano Run Job posts a tweet to X (formerly Twitter) using the X API v2.

## What It Does

The run job executes a function that:
1. Takes a text input (the tweet content)
2. Validates the input is not empty
3. Makes an authenticated POST request to the X API v2 tweets endpoint
4. Returns the created tweet's ID and content

## Required Environment Variables

Set these environment variables in your Xano workspace:

| Variable | Description | How to Get |
|----------|-------------|------------|
| `X_API_KEY` | Your X API Key (Consumer Key) | X Developer Portal → Projects & Apps → Keys and Tokens |
| `X_API_SECRET` | Your X API Secret (Consumer Secret) | X Developer Portal → Projects & Apps → Keys and Tokens |
| `X_ACCESS_TOKEN` | OAuth 2.0 Access Token | X Developer Portal → Projects & Apps → Access Token & Secret |
| `X_ACCESS_SECRET` | OAuth 2.0 Access Token Secret | X Developer Portal → Projects & Apps → Access Token & Secret |

## Prerequisites

1. **X Developer Account**: Sign up at [developer.twitter.com](https://developer.twitter.com)
2. **X Project & App**: Create a project and app in the X Developer Portal
3. **OAuth 2.0 App-only or User Context**: This job uses Bearer token authentication
4. **Write Permissions**: Your app must have "Read and Write" permissions

## How to Use

### Default Usage
Run the job with the default text:
```bash
xano run execute
```

### Custom Text via Input
Modify the `run.xs` file to change the input text:
```xs
run.job "Post to X (Twitter)" {
  main = {
    name: "post_to_x"
    input: {
      text: "Your custom tweet here!"
    }
  }
}
```

### Response Format
On success, the function returns:
```json
{
  "success": true,
  "tweet_id": "1234567890123456789",
  "text": "Hello from Xano Run Job! 🚀",
  "created_at": "2026-02-16T14:30:00Z"
}
```

## API Reference

- **Endpoint**: `POST https://api.twitter.com/2/tweets`
- **X API Documentation**: [developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference](https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets)

## Error Handling

The function handles these error cases:
- **Input Error**: Empty or missing tweet text
- **Authentication Error (401)**: Invalid credentials
- **Authorization Error (403)**: Insufficient app permissions
- **API Error**: Other X API errors with status code

## Rate Limits

X API v2 rate limits apply:
- **Essential**: 100 requests per 15 minutes
- **Elevated**: 200 requests per 15 minutes
- **Academic/Enterprise**: Higher limits

See [X API Rate Limits](https://developer.twitter.com/en/docs/twitter-api/rate-limits) for details.

## Files

```
x-create-post/
├── run.xs                    # Run job configuration
├── function/
│   └── post_to_x.xs          # Function to post tweet
└── README.md                 # This file
```

## Troubleshooting

### "Invalid X API credentials"
- Verify your access token hasn't expired
- Check that you're using the correct token for your app

### "X API access denied"
- Go to X Developer Portal → Projects & Apps → Your App → Settings
- Ensure "App permissions" is set to "Read and Write"
- Regenerate tokens after changing permissions

### "Could not authenticate you" (401)
- The Bearer token might be expired
- Try regenerating your access token

## Security Notes

- Never commit API keys to version control
- Use Xano environment variables for all credentials
- Rotate tokens regularly
- Use the minimum required permissions ("Read and Write" is sufficient)
