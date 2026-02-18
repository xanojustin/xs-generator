# Stripe Charge Customer - Xano Run Job

This Xano Run Job creates a payment intent (charge) using the [Stripe](https://stripe.com) API and logs the transaction to a database table.

## What It Does

1. Accepts payment parameters (amount, currency, customer email, description)
2. Creates a PaymentIntent via Stripe's REST API
3. Logs the transaction to the `charge_log` table
4. Returns the payment intent ID and log entry ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `STRIPE_API_KEY` | Your Stripe secret API key (get from https://dashboard.stripe.com/api-keys) |

## How to Use

### Run the Job

```bash
# Using the Xano CLI
xano run --job "Stripe Charge Customer"
```

### Customize Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {
      amount: 5000
      currency: "usd"
      customer_email: "customer@example.com"
      description: "Premium subscription"
    }
  }
  env = ["STRIPE_API_KEY"]
}
```

### Function Inputs

The `charge_customer` function accepts:

| Input | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `amount` | int | Yes | - | Amount in cents (e.g., 2000 for $20.00) |
| `currency` | text | No | "usd" | Currency code (e.g., usd, eur, gbp) |
| `customer_email` | text | Yes | - | Customer email for receipt |
| `description` | text | No | "Payment" | Description of the charge |

### Response

```json
{
  "success": true,
  "payment_intent_id": "pi_1234567890abcdef",
  "status": "requires_confirmation",
  "amount": 2000,
  "currency": "usd",
  "log_id": 1
}
```

### Error Response

If the Stripe API returns an error:

```json
{
  "name": "StripeError",
  "value": "Stripe API error: Your card was declined."
}
```

## Files

- `run.xs` - Run job configuration
- `function/charge_customer.xs` - Payment processing logic
- `table/charge_log.xs` - Database table for logging charges

## Notes

- This creates a PaymentIntent which requires confirmation (typically done on the frontend with Stripe.js)
- The payment intent status will be `requires_confirmation` until the customer completes the payment
- All transactions are logged to `charge_log` including failed attempts
- Use your Stripe test mode API key for testing (pk_test_...)
