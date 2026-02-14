# Klaviyo Create Profile Run Job

This Xano run job creates a profile in Klaviyo and optionally tracks a custom event for e-commerce and marketing automation workflows.

## What It Does

1. **Creates a profile** in Klaviyo with email, first name, last name, and phone number
2. **Optionally tracks an event** associated with the newly created profile (e.g., "Signed Up", "Purchased", "Viewed Product")

## Use Cases

- Onboard new customers to your email marketing lists
- Track user signup events for marketing attribution
- Sync user data from your app to Klaviyo for personalized campaigns
- Trigger welcome series flows in Klaviyo

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `klaviyo_api_key` | Klaviyo Private API Key | Account → Settings → API Keys → Create Private Key |

## File Structure

```
klaviyo-create-profile/
├── run.xs                    # Run job configuration
├── function/
│   └── create_profile.xs     # Main function logic
└── README.md                 # This file
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | email | Yes | Customer email address |
| `first_name` | text | No | Customer first name |
| `last_name` | text | No | Customer last name |
| `phone` | text | No | Customer phone number (E.164 format recommended) |
| `event_name` | text | No | Event to track (e.g., "Signed Up", "Purchased") |

## How to Use

### 1. Set Environment Variable

In Xano, go to your workspace settings and add:
- **Key**: `klaviyo_api_key`
- **Value**: Your Klaviyo Private API Key (starts with `pk_`)

### 2. Modify Input (Optional)

Edit `run.xs` to change the default input values:

```xs
run.job "Klaviyo Create Profile" {
  main = {
    name: "create_profile"
    input: {
      email: "your-customer@example.com"
      first_name: "Jane"
      last_name: "Smith"
      phone: "+15551234567"
      event_name: "Welcome Email Triggered"
    }
  }
  env = ["klaviyo_api_key"]
}
```

### 3. Run the Job

Execute via Xano Job Runner or CLI:
```bash
xano job run klaviyo-create-profile
```

## API Reference

This job uses the [Klaviyo REST API](https://developers.klaviyo.com/en/reference/):

- **Create Profile**: `POST /api/profiles/`
- **Create Event**: `POST /api/events/`

## Response Format

### Success (Profile Created)
```json
{
  "success": true,
  "profile_id": "01H8Z8J0K1M2N3P4Q5R6S7T8U9",
  "email": "customer@example.com",
  "event_tracked": true,
  "message": "Profile created successfully in Klaviyo"
}
```

### Error (Profile Exists)
```json
{
  "success": false,
  "error": "Profile already exists with this email",
  "email": "customer@example.com"
}
```

### Error (API Failure)
```json
{
  "success": false,
  "error": "Failed to create profile",
  "status": 400,
  "details": { ... }
}
```

## Rate Limits

Klaviyo API has rate limits. If you hit limits:
- Wait and retry
- Implement batch processing for bulk imports
- Consider using Klaviyo's bulk import endpoints for large datasets

## Troubleshooting

| Issue | Solution |
|-------|----------|
| 401 Unauthorized | Check your API key is correct and has proper permissions |
| 409 Conflict | Profile already exists - update instead of create |
| Event not tracking | Ensure event_name is provided and profile creation succeeded |

## Learn More

- [Klaviyo API Documentation](https://developers.klaviyo.com/en/reference/)
- [Klaviyo Profiles API](https://developers.klaviyo.com/en/reference/create_profile)
- [Klaviyo Events API](https://developers.klaviyo.com/en/reference/create_event)
