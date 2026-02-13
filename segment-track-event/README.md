# Segment Track Event Run Job

A XanoScript run job that tracks custom events to Segment (Twilio Segment) analytics platform.

## What It Does

This run job sends event tracking data to Segment's HTTP Tracking API:

1. **Tracks Custom Events** - Send any event with a name and properties
2. **User Identification** - Associates events with a unique user ID
3. **Rich Event Data** - Include custom properties and context for detailed analytics

Perfect for:
- E-commerce purchase tracking
- User behavior analytics
- Feature usage monitoring
- Conversion funnel analysis
- Custom business events

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `segment_write_key` | Your Segment Write Key (found in Segment dashboard) |

### Getting Your Write Key

1. Log in to your Segment dashboard: https://app.segment.com
2. Go to **Sources** → Select your source (or create one)
3. Navigate to **Settings** → **API Keys**
4. Copy the **Write Key**

**Security Note:** The write key should be kept server-side only. It allows sending data to Segment but cannot read data.

## How to Use

### 1. Set the Environment Variable

```bash
export segment_write_key="your_segment_write_key_here"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Event

Edit the `input` block in `run.xs` to track your own events:

```xs
run.job "Segment Track Event" {
  main = {
    name: "segment_track_event"
    input: {
      user_id: "user_98765"
      event: "Video Watched"
      properties: {
        video_id: "vid_abc123",
        video_title: "Getting Started with Xano",
        duration_seconds: 342,
        percent_watched: 95,
        quality: "1080p"
      }
      context: {
        page_url: "/tutorials/getting-started",
        referrer: "https://google.com"
      }
    }
  }
  env = ["segment_write_key"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user_id` | text | Yes | Unique identifier for the user (e.g., database ID) |
| `event` | text | Yes | Name of the event to track (e.g., "Product Purchased") |
| `properties` | json | No | Custom event properties as JSON object |
| `context` | json | No | Context information (IP, user agent, page URL, etc.) |
| `timestamp` | timestamp | No | When the event occurred (defaults to current time) |

### Common Event Names

| Event | Use Case |
|-------|----------|
| `Signed Up` | New user registration |
| `Product Viewed` | Viewing a product page |
| `Product Added` | Adding item to cart |
| `Checkout Started` | Beginning checkout process |
| `Order Completed` | Successful purchase |
| `Feature Used` | Using a specific feature |

## File Structure

```
segment-track-event/
├── run.xs                              # Run job configuration
├── functions/
│   └── segment_track_event.xs          # Function that calls Segment API
└── README.md                           # This file
```

## API Reference

This implementation uses Segment's HTTP Tracking API:

### Track Event
- Endpoint: `POST https://api.segment.io/v1/track`
- Documentation: https://segment.com/docs/connections/sources/catalog/libraries/server/http-api/#track

### Authentication
Uses HTTP Basic Auth with the write key as the username (password left empty):
```
Authorization: Basic {base64(write_key:)}
```

## Response

On success, the function returns:

```json
{
  "success": true,
  "user_id": "user_12345",
  "event": "Product Purchased",
  "timestamp": "2025-02-13T14:30:00Z",
  "properties": {
    "product_id": "prod_789",
    "product_name": "Premium Subscription",
    "price": 99.99,
    "currency": "USD",
    "quantity": 1
  },
  "segment_response": {
    "success": true
  }
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (user_id, event)
- Invalid Segment write key
- Segment API errors (rate limits, malformed data, etc.)

## Segment Destinations

Once events are sent to Segment, they can be forwarded to 400+ destinations including:

- **Analytics**: Google Analytics, Mixpanel, Amplitude
- **Data Warehouses**: Snowflake, BigQuery, Redshift
- **Marketing**: Mailchimp, HubSpot, Customer.io
- **CRM**: Salesforce, HubSpot, Pipedrive
- **Advertising**: Facebook Pixel, Google Ads, TikTok
- **Customer Support**: Intercom, Zendesk, Help Scout

## Testing

You can verify events are being received in your Segment dashboard:

1. Go to **Sources** → Your source
2. Click **Debugger** tab
3. Run this job and watch events appear in real-time

## License

MIT
