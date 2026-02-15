# ConvertKit Add Subscriber

A Xano Run Job that adds email subscribers to ConvertKit forms using the ConvertKit API v3.

## What This Run Job Does

This job subscribes an email address to a ConvertKit form. It's useful for:
- Adding leads from your app to your email list
- Automating newsletter signups
- Syncing user registrations with ConvertKit
- Building marketing automation workflows

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `CONVERTKIT_API_KEY` | Your ConvertKit API key (found in ConvertKit Account Settings > API) |
| `CONVERTKIT_API_SECRET` | Your ConvertKit API secret (optional, for advanced operations) |

## How to Use

### Basic Usage (with defaults)

The job comes with default input values:
- email: `subscriber@example.com`
- first_name: `Subscriber`
- form_id: `123456`

Update these in `run.xs` or pass them as inputs when running the job.

### Customize the Input

Edit `run.xs` to change the default inputs:

```xs
run.job "ConvertKit Add Subscriber" {
  main = {
    name: "convertkit_add_subscriber"
    input: {
      email: "mycustomer@example.com"
      first_name: "John"
      form_id: 654321
    }
  }
  env = ["CONVERTKIT_API_KEY", "CONVERTKIT_API_SECRET"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | email | Yes | The subscriber's email address |
| `first_name` | text | No | The subscriber's first name |
| `form_id` | int | Yes | The ConvertKit form ID to subscribe to |
| `tags` | object[] | No | Optional tags to apply (array of `{tag_name: "name"}`) |

### Finding Your Form ID

1. Log into your ConvertKit account
2. Go to "Landing Pages & Forms"
3. Click on your form
4. The form ID is in the URL or under "Embed" options

## API Response

On success, the job returns:

```json
{
  "success": true,
  "subscriber": {
    "id": 12345,
    "email_address": "subscriber@example.com",
    "state": "active",
    "created_at": "2024-01-15T10:30:00Z",
    "fields": {
      "first_name": "Subscriber"
    }
  }
}
```

On failure, it throws a `ConvertKitAPIError` with details.

## ConvertKit API Reference

- **Base URL**: `https://api.convertkit.com/v3`
- **Endpoint**: `POST /forms/{form_id}/subscribe`
- **Documentation**: https://developers.convertkit.com/

## File Structure

```
convertkit-add-subscriber/
├── run.xs                          # Run job configuration
├── function/
│   └── convertkit_add_subscriber.xs # Main function logic
├── README.md                        # This file
└── FEEDBACK.md                      # Development feedback
```

## Testing

To test this job:

1. Set your `CONVERTKIT_API_KEY` environment variable
2. Update the `form_id` in `run.xs` to one of your actual ConvertKit forms
3. Run the job
4. Check your ConvertKit account to verify the subscriber was added

## Notes

- The API key is sent in the request body (ConvertKit v3 API standard)
- Duplicate email addresses will update the existing subscriber
- Rate limits apply based on your ConvertKit plan
