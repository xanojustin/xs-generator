# Amplitude Track Event

A Xano Run Job that tracks product analytics events to [Amplitude](https://amplitude.com).

## What It Does

This run job sends product analytics events to Amplitude's HTTP API v2. It supports:

- Event tracking with custom event types
- User identification (user_id or device_id)
- Event properties (custom metadata)
- User properties (user attributes)
- Device and platform information
- Geographic data (country, region, city)
- Timestamp override

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `AMPLITUDE_API_KEY` | Your Amplitude Project API Key | [Amplitude Dashboard](https://data.amplitude.com) → Settings → Projects → [Your Project] → General → API Key |

## Usage

### As a Run Job

The run job is configured in `run.xs` with example input parameters. To run:

```bash
xano run execute --job="Amplitude Track Event"
```

### As a Function

Call the `track_event` function directly with your own inputs:

```xs
function.run "track_event" {
  input = {
    event_type: "Purchase Completed"
    user_id: "user_12345"
    event_properties: {
      product_id: "prod_678"
      price: 99.99
      currency: "USD"
    }
    user_properties: {
      plan: "premium"
      signup_date: "2024-01-15"
    }
    platform: "iOS"
    os_name: "iOS"
    os_version: "17.0"
    country: "US"
  }
} as $result
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `event_type` | text | ✅ Yes | The name of the event (e.g., "User Signup", "Purchase Completed") |
| `user_id` | text | ⚠️ Either user_id OR device_id required | Unique identifier for the user |
| `device_id` | text | ⚠️ Either user_id OR device_id required | Unique identifier for the device |
| `event_properties` | json | No | Custom properties for this specific event |
| `user_properties` | json | No | User attributes (set once per user) |
| `time` | decimal | No | Event timestamp in milliseconds since epoch (defaults to now) |
| `platform` | text | No | Platform (e.g., "iOS", "Android", "Web") |
| `os_name` | text | No | Operating system name |
| `os_version` | text | No | Operating system version |
| `device_brand` | text | No | Device brand/manufacturer |
| `device_model` | text | No | Device model |
| `carrier` | text | No | Mobile carrier |
| `country` | text | No | Country code (ISO 3166-1 alpha-2) |
| `region` | text | No | Region/state |
| `city` | text | No | City name |
| `dma` | text | No | Designated Market Area |
| `language` | text | No | Language code (e.g., "en", "es") |

## Response

On success, returns:
```json
{
  "success": true,
  "message": "Event tracked successfully",
  "event_type": "User Signup",
  "code": 200
}
```

## Error Handling

The function handles these HTTP status codes from Amplitude:

- **400** - Bad request (invalid payload)
- **413** - Payload too large
- **429** - Rate limit exceeded
- **Other** - Generic API error

## API Reference

- [Amplitude HTTP API v2 Documentation](https://www.docs.developers.amplitude.com/analytics/apis/http-v2-api/)

## Files

- `run.xs` - Run job configuration
- `function/track_event.xs` - Main event tracking function
