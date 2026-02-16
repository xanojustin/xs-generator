# Stripe Create Charge - Xano Run Job

This Xano Run Job creates a charge using the Stripe API. It demonstrates how to integrate with Stripe's payment processing service from Xano.

## What This Run Job Does

The `Stripe Create Charge` run job processes a payment by:
1. Accepting payment details (amount, currency, payment source)
2. Making an authenticated request to Stripe's `/v1/charges` endpoint
3. Returning the created charge object with details like charge ID, status, and receipt URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `stripe_secret_key` | Your Stripe Secret API Key | `sk_test_...` or `sk_live_...` |

### Getting Your Stripe API Key

1. Log in to your [Stripe Dashboard](https://dashboard.stripe.com)
2. Go to Developers → API Keys
3. Copy your **Secret Key** (starts with `sk_test_` for test mode or `sk_live_` for production)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Stripe Create Charge"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Stripe Create Charge"
}
```

### Customizing the Charge

Edit the `input` block in `run.xs`:

```xs
run.job "Stripe Create Charge" {
  main = {
    name: "stripe_charge"
    input: {
      amount: 5000        // Amount in cents ($50.00)
      currency: "usd"     // Currency code
      source: "tok_visa"  // Payment token (use Stripe.js to generate real tokens)
      description: "Payment for Order #12345"
    }
  }
  env = ["stripe_secret_key"]
}
```

### Test Tokens

Stripe provides test tokens for development:
- `tok_visa` - Visa test token
- `tok_mastercard` - Mastercard test token
- `tok_amex` - American Express test token
- `tok_chargeDeclined` - Simulates a declined charge

## File Structure

```
stripe-create-charge/
├── run.xs                    # Run job configuration
├── function/
│   └── stripe_charge.xs      # Function that calls Stripe API
└── README.md                 # This file
```

## Response Format

On success, the function returns a Stripe Charge object:

```json
{
  "id": "ch_1ABC123...",
  "object": "charge",
  "amount": 2000,
  "amount_captured": 2000,
  "amount_refunded": 0,
  "application": null,
  "application_fee": null,
  "application_fee_amount": null,
  "balance_transaction": "txn_1ABC123...",
  "billing_details": {
    "address": {
      "city": null,
      "country": null,
      "line1": null,
      "line2": null,
      "postal_code": null,
      "state": null
    },
    "email": null,
    "name": null,
    "phone": null
  },
  "calculated_statement_descriptor": "YOUR BUSINESS",
  "captured": true,
  "created": 1234567890,
  "currency": "usd",
  "customer": null,
  "description": "Test charge from Xano Run Job",
  "disputed": false,
  "failure_balance_transaction": null,
  "failure_code": null,
  "failure_message": null,
  "invoice": null,
  "livemode": false,
  "metadata": {},
  "on_behalf_of": null,
  "order": null,
  "outcome": {
    "network_status": "approved_by_network",
    "reason": null,
    "risk_level": "normal",
    "risk_score": 0,
    "seller_message": "Payment complete.",
    "type": "authorized"
  },
  "paid": true,
  "payment_intent": null,
  "payment_method": "card_1ABC123...",
  "payment_method_details": {
    "card": {
      "brand": "visa",
      "checks": {
        "address_line1_check": null,
        "address_postal_code_check": null,
        "cvc_check": null
      },
      "country": "US",
      "exp_month": 12,
      "exp_year": 2025,
      "fingerprint": "abc123...",
      "funding": "credit",
      "installments": null,
      "last4": "4242",
      "mandate": null,
      "network": "visa",
      "three_d_secure": null,
      "wallet": null
    },
    "type": "card"
  },
  "receipt_email": null,
  "receipt_number": null,
  "receipt_url": "https://pay.stripe.com/receipts/...",
  "refunded": false,
  "refunds": {
    "object": "list",
    "data": [],
    "has_more": false,
    "total_count": 0,
    "url": "/v1/charges/ch_1ABC123.../refunds"
  },
  "review": null,
  "shipping": null,
  "source": {
    "id": "card_1ABC123...",
    "object": "card",
    // ... card details
  },
  "source_transfer": null,
  "statement_descriptor": null,
  "statement_descriptor_suffix": null,
  "status": "succeeded",
  "transfer_data": null,
  "transfer_group": null
}
```

## Error Handling

The function throws a `StripeAPIError` if:
- The Stripe API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API key)
- The payment is declined

## Security Notes

- **Never commit your Stripe secret key** - always use environment variables
- Use test keys (`sk_test_...`) during development
- Only use live keys (`sk_live_...`) in production
- Consider using Stripe's Payment Intents API for stronger SCA compliance
- Implement webhook handling to receive async payment confirmations

## Additional Resources

- [Stripe API Documentation](https://stripe.com/docs/api/charges)
- [Stripe Testing Documentation](https://stripe.com/docs/testing)
- [XanoScript Documentation](https://docs.xano.com)
