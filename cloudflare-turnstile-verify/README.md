# Cloudflare Turnstile Token Verification

A Xano Run Job that verifies Cloudflare Turnstile tokens for bot protection.

## What It Does

This run job verifies Cloudflare Turnstile (CAPTCHA) tokens to distinguish between humans and bots. It's useful for:

- Login form protection
- Registration form validation
- Comment submission verification
- Any action requiring bot detection

## How It Works

1. Accepts a Turnstile token from your frontend
2. Sends it to Cloudflare's verification API
3. Returns verification results including timestamp and hostname
4. Throws an error for invalid/expired tokens

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `cloudflare_turnstile_secret_key` | Your Cloudflare Turnstile secret key (from Cloudflare dashboard) |

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `token` | string | Yes | The Turnstile token from the client widget |
| `remoteip` | string | No | Optional IP address of the user |

## Usage

### 1. Set up Cloudflare Turnstile

1. Go to [Cloudflare Turnstile](https://dash.cloudflare.com/?to=/:account/turnstile)
2. Create a new site
3. Copy your **Secret Key** (not the site key)
4. Add it to your Xano environment variables as `cloudflare_turnstile_secret_key`

### 2. Add the Widget to Your Frontend

```html
<script src="https://challenges.cloudflare.com/turnstile/v0/api.js" async defer></script>
<div class="cf-turnstile" data-sitekey="YOUR_SITE_KEY"></div>
```

### 3. Run the Verification Job

```bash
xano run run.xs \
  --input '{"token": "your-token-here", "remoteip": "1.2.3.4"}' \
  --env cloudflare_turnstile_secret_key=your_secret_key
```

## Response

On success:
```json
{
  "success": true,
  "challenge_ts": "2024-01-15T10:30:00Z",
  "hostname": "example.com",
  "action": "login",
  "cdata": "user-session-id"
}
```

On failure:
```json
{
  "error": "TurnstileVerificationFailed",
  "message": "Token verification failed: [\"timeout-or-duplicate\"]"
}
```

## Error Codes

Common Cloudflare Turnstile error codes:
- `missing-input-secret` - Secret key not provided
- `invalid-input-secret` - Secret key is invalid
- `missing-input-response` - Token not provided
- `invalid-input-response` - Token is invalid or expired
- `timeout-or-duplicate` - Token already used or timed out
- `bad-request` - Request was malformed

## Security Notes

- **Never expose your secret key** in client-side code
- **Always verify on the server** - client-side verification can be bypassed
- Tokens are single-use and expire after verification attempts
- The `remoteip` parameter adds an extra layer of validation

## Files

- `run.xs` - Run job configuration
- `function/verify_token.xs` - Token verification function
