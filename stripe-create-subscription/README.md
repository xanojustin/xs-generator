# Stripe Create Subscription

A Xano Run Job that creates Stripe subscriptions for customers.

## What This Run Job Does

This run job automates the process of creating a Stripe subscription:

1. **Creates a Stripe Customer** (if no customer_id provided)
   - Uses the provided email address
   - Optionally attaches a payment method
   
2. **Creates a Subscription**
   - Subscribes the customer to a specific price/plan
   - Uses the Stripe Subscription API
   - Returns the full subscription object

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `STRIPE_API_KEY` | Your Stripe secret API key | Stripe Dashboard → Developers → API keys |

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `customer_email` | text | Yes | Email address of the customer |
| `price_id` | text | Yes | Stripe Price ID (e.g., `price_1234567890`) |
| `customer_id` | text | No | Existing Stripe Customer ID (skips customer creation) |
| `payment_method_id` | text | No | Stripe Payment Method ID to attach |

## How to Use

### Basic Usage (creates new customer)

```xs
run.job "Stripe Create Subscription" {
  main = {
    name: "create_subscription"
    input: {
      customer_email: "user@example.com"
      price_id: "price_1234567890"
    }
  }
}
```

### With Existing Customer

```xs
run.job "Stripe Create Subscription" {
  main = {
    name: "create_subscription"
    input: {
      customer_id: "cus_1234567890"
      price_id: "price_1234567890"
      customer_email: "user@example.com"
    }
  }
}
```

### With Payment Method

```xs
run.job "Stripe Create Subscription" {
  main = {
    name: "create_subscription"
    input: {
      customer_email: "user@example.com"
      price_id: "price_1234567890"
      payment_method_id: "pm_1234567890"
    }
  }
}
```

## Response

On success, returns:

```json
{
  "success": true,
  "subscription": {
    "id": "sub_1234567890",
    "object": "subscription",
    "status": "active",
    "customer": "cus_1234567890",
    "items": {
      "data": [
        {
          "price": {
            "id": "price_1234567890"
          }
        }
      ]
    },
    ...
  }
}
```

## Error Handling

The run job handles errors from the Stripe API:

- **Input validation errors** (400) - Missing required fields
- **Stripe API errors** - Card declined, invalid price ID, etc.

Errors are thrown with detailed messages from Stripe's API response.

## Files

- `run.xs` - Run job configuration
- `function/create_subscription.xs` - Main function implementation

## Notes

- Stripe uses Basic authentication with the API key base64-encoded
- The subscription is created immediately (not a trial)
- For production use, consider adding webhook handling for subscription events
