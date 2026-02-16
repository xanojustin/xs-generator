# Stripe Payment Run Job

A Xano Run Job that demonstrates Stripe payment processing by creating customers and charging them via the Stripe API.

## What This Run Job Does

This run job performs the following operations:

1. **Creates a Stripe Customer** - Creates a new customer record in Stripe with an email address
2. **Creates a Payment Intent** - Initializes a payment of the specified amount and currency
3. **Stores Payment Record** - Optionally saves the transaction details to a local database table
4. **Returns Transaction Details** - Provides the payment intent ID, customer ID, status, and receipt URL

## Use Cases

- One-time payment processing
- Subscription initial setup
- E-commerce checkout backend
- Invoice payment automation
- Payment reconciliation jobs

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `stripe_secret_key` | Your Stripe Secret API Key | Get from Stripe Dashboard → Developers → API Keys |

## File Structure

```
~/xs/stripe-payment/
├── run.xs                          # Run job configuration
├── function/
│   ├── charge_customer.xs          # Main function to process payment
│   └── create_stripe_customer.xs   # Helper to create Stripe customers
└── README.md                       # This file
```

## How to Use

### 1. Set Up Environment Variables

In your Xano workspace settings, add:
- `stripe_secret_key` = `sk_test_...` (for testing) or `sk_live_...` (for production)

### 2. Run the Job

```bash
# Via Xano CLI or dashboard
xano run start stripe-payment
```

### 3. Customize the Input

Edit `run.xs` to change the payment parameters:

```xs
run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {
      amount: 5000           // Amount in cents ($50.00)
      currency: "usd"        // Currency code
      description: "Monthly subscription"
      customer_email: "user@yourdomain.com"
    }
  }
  env = ["stripe_secret_key"]
}
```

### 4. Optional: Add Payment Table

To store payment records locally, create a table named `payment` with these fields:
- `id` (int, primary key)
- `payment_intent_id` (text)
- `customer_id` (text)
- `amount` (int)
- `currency` (text)
- `status` (text)
- `created_at` (timestamp)

## Response Format

```json
{
  "success": true,
  "payment_intent_id": "pi_1234567890abcdef",
  "customer_id": "cus_1234567890abcdef",
  "amount": 2000,
  "currency": "usd",
  "status": "requires_payment_method",
  "receipt_url": "https://pay.stripe.com/receipts/..."
}
```

## Important Notes

- **Amount is in cents** - $20.00 = 2000
- **Test Mode** - Use test API keys for development (cards like `4242 4242 4242 4242` work)
- **Payment Confirmation** - This creates a payment intent; actual charging requires frontend confirmation for SCA compliance
- **Error Handling** - The job includes validation and error handling for API failures

## Stripe API Reference

- [Payment Intents API](https://stripe.com/docs/api/payment_intents)
- [Customers API](https://stripe.com/docs/api/customers)
- [Testing Cards](https://stripe.com/docs/testing)

## Security Considerations

- Never commit your Stripe secret key to version control
- Use environment variables for all secrets
- Use restricted API keys in production (limit to only needed permissions)
- Enable Stripe webhook signature verification for production use
