# Stripe Create Customer and Charge Run Job

A XanoScript run job that creates a Stripe customer and charges their payment method in one flow.

## What It Does

This run job performs two key Stripe operations:
1. **Creates a Customer** - Stores customer details (email, name) in Stripe
2. **Creates and Confirms a Payment Intent** - Charges the customer's saved payment method

Perfect for one-time purchases, subscriptions setup, or any payment flow where you need to charge a customer immediately.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `stripe_secret_key` | Your Stripe Secret API key (starts with `sk_`) |

Get your API key from: https://dashboard.stripe.com/apikeys

**Security Note:** Never use publishable keys (pk_) here. Only use secret keys (sk_) which should be kept server-side.

## How to Use

### 1. Set the Environment Variable

```bash
export stripe_secret_key="sk_test_your_key_here"  # Test mode
# or
export stripe_secret_key="sk_live_your_key_here"  # Production mode
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Charge

Edit the `input` block in `run.xs` to customize:

```xs
run.job "Stripe Create Customer and Charge" {
  main = {
    name: "stripe_create_charge"
    input: {
      customer_email: "customer@yourdomain.com"
      customer_name: "Jane Smith"
      amount: 99.99
      currency: "usd"
      description: "Pro Plan - Monthly"
      payment_method: "pm_1234567890abcdef"
    }
  }
  env = ["stripe_secret_key"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `customer_email` | email | Yes | Customer's email address |
| `customer_name` | text | Yes | Customer's full name |
| `amount` | number | Yes | Charge amount (in dollars, e.g., 49.99 for $49.99) |
| `currency` | text | No | 3-letter ISO currency code (default: `usd`) |
| `description` | text | No | Description of the charge (shown on receipts) |
| `payment_method` | text | Yes | Stripe Payment Method ID (e.g., `pm_xxx` or `pm_card_visa` for test) |

### Payment Method IDs for Testing

Stripe provides test payment methods that don't require real cards:

| Test Method | ID | Result |
|-------------|-----|--------|
| Visa | `pm_card_visa` | Successful payment |
| Visa (debit) | `pm_card_visa_debit` | Successful payment |
| Mastercard | `pm_card_mastercard` | Successful payment |
| Declined | `pm_card_visa_chargeDeclined` | Payment fails |

Full list: https://docs.stripe.com/testing#cards

## File Structure

```
stripe-create-charge/
├── run.xs                              # Run job configuration
├── functions/
│   └── stripe_create_charge.xs         # Function that calls Stripe API
└── README.md                           # This file
```

## API Reference

This implementation uses two Stripe APIs:

### Create Customer
- Endpoint: `POST https://api.stripe.com/v1/customers`
- Documentation: https://docs.stripe.com/api/customers/create

### Create Payment Intent
- Endpoint: `POST https://api.stripe.com/v1/payment_intents`
- Documentation: https://docs.stripe.com/api/payment_intents/create

## Response

On success, the function returns:

```json
{
  "success": true,
  "customer_id": "cus_abc123",
  "customer_email": "customer@example.com",
  "payment_intent_id": "pi_xyz789",
  "amount": 49.99,
  "currency": "usd",
  "status": "succeeded",
  "description": "Premium Plan Subscription"
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (email, name, amount, payment_method)
- Invalid amount (must be > 0)
- Stripe API errors (invalid keys, declined cards, etc.)

## License

MIT
