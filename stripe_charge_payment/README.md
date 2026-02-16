# Stripe Charge Payment Run Job

This Xano run job creates a charge on Stripe for a specified customer.

## What It Does

The run job processes payments by:
1. Validating input parameters (customer_id, amount, currency)
2. Logging the charge attempt
3. Calling Stripe's Charges API to create a payment
4. Returning the charge result with Stripe's charge ID

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `STRIPE_SECRET_KEY` | Your Stripe secret API key (starts with `sk_`) |

## How to Use

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `customer_id` | text | Yes | The Stripe customer ID (e.g., `cus_1234567890`) |
| `amount` | int | Yes | The amount to charge in the smallest currency unit (e.g., cents for USD) |
| `currency` | text | Yes | The 3-letter ISO currency code (e.g., `usd`, `eur`) |
| `description` | text | No | An optional description for the charge |

### Running via Xano CLI

```bash
xano run:exec ./run/stripe_charge_payment.xs --args '{
  "customer_id": "cus_ABC123XYZ",
  "amount": 5000,
  "currency": "usd",
  "description": "Payment for Order #12345"
}'
```

This would charge $50.00 USD to the specified customer.

### Using the Function

You can also call the function from other XanoScript code:

```xs
function.run "stripe_create_charge" {
  input = {
    customer_id: "cus_ABC123XYZ",
    amount: 5000,
    currency: "usd",
    description: "Payment for Order #12345"
  }
} as $charge_result
```

### Response

On success, returns the full Stripe charge object:

```json
{
  "id": "ch_1ABC...",
  "object": "charge",
  "amount": 5000,
  "currency": "usd",
  "customer": "cus_ABC123XYZ",
  "description": "Payment for Order #12345",
  "status": "succeeded",
  ...
}
```

## Files

- `function/stripe_create_charge.xs` - Reusable function for Stripe API calls
- `run/stripe_charge_payment.xs` - The run job for direct execution

## Notes

- Amounts should be in the smallest currency unit (e.g., cents for USD, not dollars)
- The Stripe customer must already exist in your Stripe account
- For production use, ensure your Stripe secret key is stored securely as an environment variable
- The run job uses Xano's simplified run syntax (not wrapped in a function block)
