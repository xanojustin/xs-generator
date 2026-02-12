# Stripe Payment Intent Run Job

This Xano run job creates a Stripe Payment Intent to charge customers securely.

## What It Does

This run job:
1. Creates a new Stripe Payment Intent via the Stripe API
2. Stores the payment intent record in a local database table
3. Returns the client secret and payment intent details

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `stripe_secret_key` | Your Stripe Secret API Key | Dashboard → Developers → API Keys → Secret key |

## Files Structure

```
~/xs/stripe-payment-intent/
├── run.xs                    # Run job configuration
├── functions/
│   └── create_payment_intent.xs  # Main function logic
├── tables/
│   └── payment_intents.xs    # Database table schema
└── README.md                 # This file
```

## How to Use

### 1. Set Environment Variable

```bash
export stripe_secret_key="sk_test_..."
```

### 2. Run the Job

```bash
# Run with default values (5000 cents = $50.00 USD)
xano run ./run.xs

# Or customize via input overrides (depends on your runner)
```

### 3. Default Input Values

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| `amount` | 5000 | Amount in cents (5000 = $50.00) |
| `currency` | "usd" | ISO currency code |
| `description` | "Test payment via Xano run job" | Payment description |

### 4. Response

On success, the job returns:

```json
{
  "success": true,
  "payment_intent_id": "pi_1234567890",
  "client_secret": "pi_1234567890_secret_...",
  "status": "requires_payment_method",
  "amount": 5000,
  "currency": "usd",
  "db_record_id": 1
}
```

## Stripe API Reference

- [Payment Intents API](https://stripe.com/docs/api/payment_intents)
- [Stripe Testing](https://stripe.com/docs/testing)

## Testing with Stripe Test Cards

Use these test card numbers in your frontend:

| Card Number | Scenario |
|-------------|----------|
| `4242 4242 4242 4242` | Success |
| `4000 0000 0000 0002` | Card declined |
| `4000 0000 0000 9995` | Insufficient funds |

## Security Notes

- Never commit your Stripe secret key
- The `client_secret` is safe to pass to the frontend
- Always use HTTPS in production
- Enable Stripe webhook signing for production

## Customization

To modify the payment intent behavior, edit `functions/create_payment_intent.xs`:

- Add customer ID: `"customer": "cus_..."`
- Add receipt email: `"receipt_email": "customer@example.com"`
- Enable shipping: Add shipping configuration
- Add more metadata fields
