# RevenueCat Get Subscriber

This Xano Run Job fetches subscriber information from the RevenueCat API. RevenueCat is a popular service for managing in-app purchases and subscriptions across iOS, Android, and web platforms.

## What This Run Job Does

Fetches detailed subscriber information including:
- Original app user ID (for aliased users)
- First and last seen timestamps
- Active entitlements
- Subscription status for all products
- Non-subscription purchases

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `revenuecat_api_key` | Your RevenueCat secret API key | RevenueCat Dashboard → Project Settings → API Keys → Secret API Key |

## How to Use

### Local Development

1. Set the environment variable:
   ```bash
   export revenuecat_api_key="your_secret_api_key"
   ```

2. Run the job:
   ```bash
   xano run
   ```

### With Custom User ID

Modify the `run.xs` file to change the `app_user_id`:

```xs
run.job "RevenueCat Get Subscriber" {
  main = {
    name: "get_subscriber"
    input: {
      app_user_id: "your_custom_user_id"
    }
  }
  env = ["revenuecat_api_key"]
}
```

## API Reference

This run job uses the RevenueCat REST API:
- **Endpoint**: `GET /v1/subscribers/{app_user_id}`
- **Documentation**: https://docs.revenuecat.com/docs/subscribers

## Response Format

```json
{
  "app_user_id": "user_12345",
  "original_app_user_id": "user_12345",
  "first_seen": "2024-01-15T10:30:00Z",
  "last_seen": "2024-02-15T08:45:00Z",
  "entitlements": {
    "premium": {
      "expires_date": "2024-03-15T10:30:00Z",
      "product_identifier": "monthly_premium",
      "purchase_date": "2024-02-15T10:30:00Z"
    }
  },
  "subscriptions": {
    "monthly_premium": {
      "expires_date": "2024-03-15T10:30:00Z",
      "purchase_date": "2024-02-15T10:30:00Z",
      "store": "app_store",
      "is_sandbox": false
    }
  },
  "non_subscriptions": {}
}
```

## File Structure

```
revenuecat-get-subscriber/
├── run.xs                      # Run job configuration
├── function/
│   └── get_subscriber.xs       # Main function
└── README.md                   # This file
```

## Error Handling

The run job handles the following error cases:
- Missing `app_user_id` input (inputerror)
- RevenueCat API failures (standard error with status code)
- Network timeouts (30 second timeout configured)

## Use Cases

- Check if a user has an active subscription
- Migrate subscriber data to your own database
- Debug subscription issues
- Generate reports on subscriber status
- Verify entitlements before granting premium features

## Security Notes

- Never commit your RevenueCat API key to version control
- Use environment variables or Xano's environment variable system
- The secret API key grants full access to your RevenueCat project
