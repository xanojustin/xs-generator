# Stripe Charge Customer - Xano Run Job

This Xano run job creates a charge for a customer using the Stripe API.

## What It Does

The run job executes a function that charges a customer's payment method using Stripe. It handles:

- Authentication with Stripe using your Secret Key
- Converting dollar amounts to cents (Stripe's smallest currency unit)
- Creating a charge for an existing Stripe customer
- Optionally using a specific payment method
- Returning detailed charge information including receipt URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `stripe_secret_key` | Your Stripe Secret Key (starts with sk_...) | `sk_live_...` or `sk_test_...` |
| `stripe_amount` | Amount to charge (in dollars, will be converted to cents) | `10.00` (charges $10.00) |
| `stripe_customer_id` | Stripe Customer ID to charge | `cus_xxxxxxxxxxxxxxxx` |

## Optional Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `stripe_currency` | 3-letter ISO currency code | `usd` |
| `stripe_payment_method_id` | Specific payment method to use (card ID, etc.) | Uses customer's default payment method |

## How to Use

### 1. Set Environment Variables

Configure the required environment variables in your Xano workspace settings.

### 2. Run the Job

Execute the run job using the Xano CLI or dashboard:

```bash
xano run execute stripe-charge-customer
```

### 3. Customize the Charge

Set the `stripe_amount` to the dollar amount you want to charge. For example, `stripe_amount=49.99` will charge $49.99 (converted to 4999 cents for Stripe).

## File Structure

```
stripe-charge-customer/
├── run.xs                      # Run job configuration
├── function/
│   └── charge_customer.xs      # Charge creation function
├── README.md                   # This file
└── FEEDBACK.md                 # Development feedback for MCP improvements
```

## Stripe API Reference

- **Endpoint**: `POST https://api.stripe.com/v1/charges`
- **Auth**: Bearer Token (Secret Key)
- **Parameters**:
  - `amount`: Amount in smallest currency unit (cents)
  - `currency`: 3-letter ISO code (e.g., `usd`, `eur`)
  - `customer`: Stripe Customer ID
  - `source`: Payment method ID (optional, uses default if not provided)

## Response Format

### Success

```json
{
  "status": "success",
  "message": "Charge created successfully. Charge ID: ch_xxxxxxxxxxxxxxxx",
  "charge_id": "ch_xxxxxxxxxxxxxxxx",
  "amount": 1000,
  "currency": "usd",
  "status": "succeeded",
  "receipt_url": "https://pay.stripe.com/receipts/...",
  "stripe_response": { ... }
}
```

### Error

```json
{
  "status": "error",
  "message": "Failed to create charge. Status: 402, Error: Your card was declined.",
  "stripe_response": { ... }
}
```

## Testing with Stripe Test Mode

Use Stripe test keys (starting with `sk_test_`) to simulate charges without real money:

- **Test card**: `4242 4242 4242 4242` (Visa)
- **Declined card**: `4000 0000 0000 0002`

See [Stripe Testing Documentation](https://stripe.com/docs/testing) for more test cards.

## Security Notes

- Never expose your Secret Key in client-side code
- Use Stripe webhooks to handle async events (refunds, disputes)
- Consider implementing idempotency keys for production use
- Store charge IDs in your database for reference

## Notes

- Amounts are automatically converted from dollars to cents
- The charge will use the customer's default payment method if `stripe_payment_method_id` is not specified
- Standard Stripe processing fees apply based on your pricing plan
