# Stripe Charge Customer Run Job

This XanoScript run job charges a customer using the Stripe API via Payment Intents.

## What It Does

This run job creates a Stripe Payment Intent to charge a customer's payment method. It handles:

- Creating a payment intent with the specified amount and currency
- Confirming the payment immediately
- Supporting optional customer ID association
- Sending email receipts to customers
- Returning the payment intent ID and status

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `STRIPE_API_KEY` | Your Stripe secret API key (starts with `sk_`) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `amount` | text | Yes | Amount to charge in cents (e.g., `2000` for $20.00) |
| `currency` | text | No | Currency code (default: `usd`) |
| `payment_method` | text | Yes | Stripe payment method ID (e.g., `pm_1234567890`) |
| `description` | text | No | Description of the charge |
| `customer_id` | text | No | Stripe customer ID (e.g., `cus_1234567890`) |
| `receipt_email` | text | No | Email address to send receipt to |

### Response

```json
{
  "success": true,
  "payment_intent_id": "pi_1234567890",
  "status": "succeeded",
  "client_secret": "pi_1234567890_secret_xxxxxxxx",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "payment_intent_id": null,
  "status": null,
  "client_secret": null,
  "error": "Your card was declined."
}
```

## File Structure

```
stripe-charge-customer/
├── run.xs                    # Run job definition
├── function/
│   └── charge_customer.xs    # Function to charge customer
└── README.md                 # This file
```

## Stripe API Reference

- [Payment Intents API](https://stripe.com/docs/api/payment_intents)
- [Testing Cards](https://stripe.com/docs/testing#cards)

## Testing

Use Stripe's test card numbers for testing:
- `4242424242424242` - Visa (successful payment)
- `4000000000000002` - Card declined
- `4000000000009995` - Insufficient funds

## Security Notes

- Never commit your `STRIPE_API_KEY` to version control
- Use Stripe's test mode keys during development
- The API key should have restricted permissions if possible
