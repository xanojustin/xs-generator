# LemonSqueezy Create Checkout Run Job

This XanoScript run job creates a checkout session using the LemonSqueezy API. LemonSqueezy is a popular payment platform for SaaS businesses that handles payments, subscriptions, and digital product sales.

## What It Does

This run job creates a LemonSqueezy checkout session that:

- Generates a secure checkout URL for customers to purchase products
- Supports pre-filling customer email and name
- Allows custom redirect URLs after purchase
- Supports pay-what-you-want pricing
- Returns the checkout URL and session details

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `LEMONSQUEEZY_API_KEY` | Your LemonSqueezy API key (starts with `lemonsqueezy_`) |

## How to Use

### Run the Job

The job is configured with placeholder values in `run.xs`. Update the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `store_id` | text | Yes | Your LemonSqueezy store ID (found in dashboard) |
| `variant_id` | text | Yes | Product variant ID to sell (found in product settings) |
| `customer_email` | text | No | Pre-fill customer email address |
| `customer_name` | text | No | Pre-fill customer name |
| `redirect_url` | text | No | URL to redirect customer after checkout |
| `custom_price` | text | No | Custom price in cents (for pay-what-you-want products) |

### Response

```json
{
  "success": true,
  "checkout_id": "123456789",
  "checkout_url": "https://your-store.lemonsqueezy.com/checkout/buy/xxxx-xxxx",
  "status": "pending",
  "expires_at": "2026-02-15T12:00:00.000000Z",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "checkout_id": null,
  "checkout_url": null,
  "status": null,
  "expires_at": null,
  "error": "Store not found or invalid variant ID"
}
```

## File Structure

```
lemonsqueezy-create-checkout/
├── run.xs                      # Run job definition
├── function/
│   └── create_checkout.xs      # Function to create checkout
└── README.md                   # This file
```

## Getting Started with LemonSqueezy

1. Create an account at [lemonsqueezy.com](https://lemonsqueezy.com)
2. Set up your store and add products
3. Generate an API key in your store settings
4. Find your Store ID in the dashboard (Settings > Store)
5. Find your Variant ID in product settings (Products > [Product] > Variants)

## LemonSqueezy API Reference

- [LemonSqueezy API Documentation](https://docs.lemonsqueezy.com/api)
- [Checkout API](https://docs.lemonsqueezy.com/api/checkouts)
- [Authentication](https://docs.lemonsqueezy.com/api/authentication)

## Testing

Use LemonSqueezy's test mode during development:
- Enable "Test Mode" in your store settings
- Use test API keys (they look the same, but work on test data)
- Test checkouts won't process real payments

## Security Notes

- Never commit your `LEMONSQUEEZY_API_KEY` to version control
- Use test mode API keys during development
- Store API keys as environment variables
- The checkout URL is safe to share with customers

## Webhook Integration

For production use, set up webhooks to receive payment notifications:

1. Go to Settings > Webhooks in LemonSqueezy dashboard
2. Add your webhook endpoint URL
3. Subscribe to events: `order_created`, `subscription_created`, etc.
4. Use the webhook payload to update your database

## Use Cases

- **E-commerce**: Sell digital products with hosted checkout
- **SaaS**: Create subscription checkouts for your service
- **Pay-what-you-want**: Let customers choose their price
- **Pre-filled checkouts**: Streamline checkout for logged-in users
