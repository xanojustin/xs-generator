# Bluesky Create Post Run Job

A Xano Run Job that creates posts (called "skeets") on [Bluesky](https://bsky.app), a decentralized social network built on the AT Protocol.

## What This Run Job Does

This run job authenticates with Bluesky using your handle and app password, then creates a new post with the specified text content. It uses Bluesky's AT Protocol API via the `com.atproto` endpoints.

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `bluesky_handle` | Your Bluesky handle (e.g., `username.bsky.social`) | Your Bluesky profile |
| `bluesky_password` | Bluesky App Password | Settings → App Passwords on Bluesky |

**Security Note:** Never use your main Bluesky password. Always create an App Password from your Bluesky account settings.

## How to Use

### Running the Job

```bash
# Via Xano CLI or Dashboard
xano run execute bluesky-create-post
```

### Customizing the Post

Edit `run.xs` to change the post content:

```xs
run.job "Bluesky Create Post" {
  main = {
    name: "bluesky_create_post"
    input: {
      text: "Your custom message here!"
    }
  }
}
```

### Using in Other Functions

```xs
function.run "bluesky_create_post" {
  input = {
    text: "Hello from my app!"
  }
} as $result
```

## API Flow

1. **Authentication** → `com.atproto.server.createSession`
2. **Create Record** → `com.atproto.repo.createRecord`

## Response

On success, returns:
```json
{
  "uri": "at://did:plc:xxx/app.bsky.feed.post/xxx",
  "cid": "bafyrei..."
}
```

## Bluesky Resources

- [Bluesky Website](https://bsky.app)
- [AT Protocol Docs](https://atproto.com)
- [Bluesky API Reference](https://docs.bsky.app)
