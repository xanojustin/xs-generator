# Segment Track Event - Xano Run Job

This Xano Run Job sends a track event to Segment (customer data platform). It demonstrates how to integrate with Segment's analytics API from Xano to track user actions and events.

## What This Run Job Does

The `Segment Track Event` run job sends analytics data by:
1. Accepting event data (event name, user ID, properties)
2. Making an authenticated request to Segment's Track API
3. Returning a success confirmation or error details

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `segment_write_key` | Your Segment Write Key | `sk_test_...` or your production write key |

### Getting Your Segment Write Key

1. Log in to your [Segment Dashboard](https://app.segment.com)
2. Select your Source
3. Go to Settings → API Keys
4. Copy your **Write Key**

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Segment Track Event"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Segment Track Event"
}
```

### Customizing the Event

Edit the `input` block in `run.xs`:

```xs
run.job "Segment Track Event" {
  main = {
    name: "segment_track"
    input: {
      event: "Order Completed"
      user_id: "user_12345"
      properties: {
        order_id: "order_67890"
        total: 99.99
        currency: "USD"
        products: ["Product A", "Product B"]
      }
    }
  }
  env = ["segment_write_key"]
}
```

## File Structure

```
segment-track-event/
├── run.xs                      # Run job configuration
├── function/
│   └── segment_track.xs        # Function that calls Segment API
└── README.md                   # This file
```

## Response Format

On success, the function returns a success confirmation:

```json
{
  "success": true
}
```

## Event Types

Common Segment track events include:
- `Signed Up` - User registration
- `Product Viewed` - Product page view
- `Product Added` - Item added to cart
- `Order Completed` - Purchase completed
- `User Logged In` - Login event

## Error Handling

The function throws a `SegmentAPIError` if:
- The Segment API returns a non-2xx status code
- The request times out
- Authentication fails (invalid write key)
- The event data is malformed

## Security Notes

- **Never commit your Segment write key** - always use environment variables
- Use a test Source during development
- Consider batching events for high-volume scenarios
- Implement retry logic for failed events

## Additional Resources

- [Segment Track API Documentation](https://segment.com/docs/connections/sources/catalog/libraries/server/http-api/#track)
- [Segment Event Naming Best Practices](https://segment.com/academy/collecting-data/naming-conventions-for-clean-data/)
- [XanoScript Documentation](https://docs.xano.com)
