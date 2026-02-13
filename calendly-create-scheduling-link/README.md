# Calendly Create Scheduling Link Run Job

A XanoScript run job that creates single-use scheduling links in Calendly.

## What It Does

This run job creates a **single-use scheduling link** via the Calendly API. These links are perfect for:

- Sending personalized booking links to specific clients
- Creating time-sensitive scheduling opportunities
- Controlling how many times a link can be used
- Tracking which links resulted in bookings

When someone uses the link, they can schedule one meeting (or the specified number of meetings) before the link expires.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `calendly_api_token` | Your Calendly Personal Access Token |

### Getting Your API Token

1. Log in to your Calendly account at https://calendly.com
2. Go to **Integrations** → **API & Webhooks**
3. Click **Generate New Token** under "Personal Access Tokens"
4. Copy the token and store it securely

## How to Use

### 1. Set the Environment Variable

```bash
export calendly_api_token="your_token_here"
```

### 2. Find Your Event Type URI

To create a scheduling link, you need the **event type URI**. You can find this by:

**Option A: Using the Calendly API**
```bash
curl --request GET \
  --url 'https://api.calendly.com/event_types' \
  --header 'authorization: Bearer {your_token}'
```

**Option B: From your Calendly dashboard**
1. Go to your Calendly dashboard
2. Click on the event type you want to use
3. The URI will be in the format: `https://api.calendly.com/event_types/{uuid}`

### 3. Customize the Run Job

Edit the `input` block in `run.xs`:

```xs
run.job "Calendly Create Scheduling Link" {
  main = {
    name: "calendly_create_scheduling_link"
    input: {
      event_type_uri: "https://api.calendly.com/event_types/YOUR_EVENT_TYPE_UUID"
      max_event_count: 1
    }
  }
  env = ["calendly_api_token"]
}
```

### 4. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event_type_uri` | text | Yes | The Calendly event type URI (e.g., `https://api.calendly.com/event_types/abc123`) |
| `max_event_count` | int | No | How many times the link can be used (default: `1`) |

## File Structure

```
calendly-create-scheduling-link/
├── run.xs                              # Run job configuration
├── functions/
│   └── calendly_create_scheduling_link.xs  # Function that calls Calendly API
└── README.md                           # This file
```

## API Reference

This implementation uses the Calendly API v2:

### Create Scheduling Link
- **Endpoint:** `POST https://api.calendly.com/scheduling_links`
- **Documentation:** https://developer.calendly.com/api-docs
- **Authentication:** Bearer token (Personal Access Token)

### Request Body
```json
{
  "max_event_count": 1,
  "owner": "https://api.calendly.com/event_types/{uuid}",
  "owner_type": "EventType"
}
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "scheduling_link": {
    "url": "https://calendly.com/d/abc123/30min",
    "expires_at": "2025-05-15T12:00:00.000000Z",
    "max_event_count": 1,
    "remaining_event_count": 1
  },
  "message": "Scheduling link created successfully"
}
```

### Response Fields

| Field | Description |
|-------|-------------|
| `url` | The scheduling link to share with invitees |
| `expires_at` | When the link expires (90 days from creation) |
| `max_event_count` | Total number of bookings allowed |
| `remaining_event_count` | Bookings remaining |

## Error Handling

The function validates inputs and returns clear error messages for:

- Missing event type URI
- Invalid max event count (must be > 0)
- Missing API token
- Calendly API errors (invalid token, invalid event type, etc.)

### Common Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `Authentication failed` | Invalid or expired token | Regenerate your personal access token |
| `Resource not found` | Invalid event type URI | Verify the event type UUID is correct |
| `Forbidden` | Insufficient permissions | Ensure your Calendly plan supports API access |

## Important Notes

- **Link Expiration:** Single-use links expire after 90 days by default
- **Plan Requirements:** API access requires a paid Calendly plan (Standard or higher)
- **Usage Limits:** Calendly may rate-limit excessive API requests
- **Security:** Keep your personal access token secure - it grants full access to your Calendly account

## Use Cases

1. **Sales Outreach:** Send personalized scheduling links to prospects
2. **Client Onboarding:** Create one-time links for new client kickoff calls
3. **Support Escalations:** Generate links for premium support sessions
4. **Event RSVPs:** Control attendance by limiting bookings per link
5. **Consulting Calls:** Create paid consultation scheduling workflows

## License

MIT
