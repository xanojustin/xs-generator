# Klaviyo Track Event Integration

This XanoScript integration provides a complete solution for syncing customer data and events to Klaviyo, a leading customer data and marketing automation platform.

## What This Run Job Does

This integration enables you to:

1. **Create or Update Klaviyo Profiles** - Sync user data (email, name, phone, custom properties) to Klaviyo
2. **Track Custom Events** - Send user activity events (purchases, signups, page views) to Klaviyo for segmentation and triggered flows
3. **Batch Sync via Scheduled Task** - Automatically sync recent user activity to Klaviyo on a schedule
4. **Real-time Event Tracking API** - Expose an API endpoint to track events immediately as they happen

## Required Environment Variables

Add these to your Xano environment:

| Variable | Description | Example |
|----------|-------------|---------|
| `KLAVIYO_API_KEY` | Your Klaviyo Private API Key | `pk_abc123...` |
| `KLAVIYO_BASE_URL` | Klaviyo API base URL | `https://a.klaviyo.com/api` |

### Getting Your Klaviyo API Key

1. Log in to your Klaviyo account
2. Go to Settings → API Keys
3. Create a Private API Key with these scopes:
   - `profiles:write` - Create and update profiles
   - `events:write` - Track custom events

## File Structure

```
klaviyo-track-event/
├── README.md
├── functions/
│   ├── klaviyo_create_profile.xs    # Create/update a Klaviyo profile
│   └── klaviyo_track_event.xs       # Track a custom event in Klaviyo
├── apis/
│   └── klaviyo/
│       └── track_event.xs           # API endpoint for real-time event tracking
└── tasks/
    └── sync_user_activity.xs        # Scheduled task to batch sync activity
```

## Usage

### 1. Track a Single Event via API

Send a POST request to your Xano API endpoint:

```http
POST /klaviyo/track_event
Content-Type: application/json

{
  "email": "customer@example.com",
  "event_name": "Product Purchased",
  "timestamp": "2026-02-13T14:30:00Z",
  "properties": {
    "product_name": "Premium Widget",
    "price": 49.99,
    "currency": "USD",
    "quantity": 2
  },
  "profile_properties": {
    "first_name": "John",
    "last_name": "Doe",
    "phone": "+1234567890"
  }
}
```

### 2. Batch Sync via Scheduled Task

The scheduled task (`sync_user_activity.xs`) runs every hour to:
- Query recent user activity from your database
- Sync new/updated profiles to Klaviyo
- Track batched events for efficiency

Modify the schedule in the task file to adjust frequency.

### 3. Use Functions in Your Own Code

```xs
// Create or update a profile
function.run "klaviyo_create_profile" {
  input = {
    email: "user@example.com",
    first_name: "Jane",
    last_name: "Smith",
    phone: "+15551234567",
    custom_properties: {plan: "premium", signup_source: "web"}
  }
} as $profile_result

// Track an event
function.run "klaviyo_track_event" {
  input = {
    email: "user@example.com",
    event_name: "Completed Onboarding",
    timestamp: now,
    properties: {step_completed: 5, time_spent_seconds: 120},
    profile_properties: {first_name: "Jane", last_name: "Smith"}
  }
} as $event_result
```

## API Reference

### Klaviyo Create Profile Function

Creates or updates a profile in Klaviyo using the `profile-import` endpoint.

**Input:**
- `email` (required) - User's email address
- `first_name` (optional) - First name
- `last_name` (optional) - Last name  
- `phone` (optional) - Phone number
- `external_id` (optional) - Your system's user ID
- `custom_properties` (optional) - Object with custom profile properties

**Output:**
- `success` - Boolean indicating success
- `profile_id` - Klaviyo profile ID
- `response` - Full API response

### Klaviyo Track Event Function

Tracks a custom event in Klaviyo using the `events` endpoint.

**Input:**
- `email` (required) - User's email address
- `event_name` (required) - Name of the event (e.g., "Product Purchased")
- `timestamp` (optional) - Event timestamp (defaults to now)
- `properties` (optional) - Event properties object
- `profile_properties` (optional) - Profile data to include

**Output:**
- `success` - Boolean indicating success
- `event_id` - Klaviyo event ID
- `response` - Full API response

## Event Naming Best Practices

Use consistent, descriptive event names:

- ✅ `Product Purchased`
- ✅ `Account Created`
- ✅ `Onboarding Completed`
- ❌ `purchase` (too vague)
- ❌ `event_123` (not descriptive)

## Testing

1. Set up your environment variables in Xano
2. Test the `klaviyo_create_profile` function with a test email
3. Check your Klaviyo account → Profiles to verify the profile was created
4. Test the `klaviyo_track_event` function
5. In Klaviyo, go to Analytics → Metrics to see your custom events

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Unauthorized" error | Check your `KLAVIYO_API_KEY` is correct and has proper scopes |
| Events not appearing | Events may take 1-2 minutes to appear in Klaviyo analytics |
| Rate limiting | Klaviyo allows 350 requests/second. Add delays if needed |
| Profile not updating | Use the same `email` or `external_id` for updates |

## Resources

- [Klaviyo API Documentation](https://developers.klaviyo.com/en/reference/)
- [Klaviyo Events API Guide](https://developers.klaviyo.com/en/docs/track_events)
- [XanoScript Documentation](https://docs.xano.com)

## License

MIT - Use freely in your Xano projects.
