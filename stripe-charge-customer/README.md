# Stripe Charge Customer - Xano Run Job

This Xano Run Job creates a charge on a customer's Stripe account.

## What It Does

This run job charges a Stripe customer using the Stripe API. It:

1. Validates input parameters (customer_id must be present, amount must be > 0)
2. Converts the decimal amount to cents (Stripe uses smallest currency unit)
3. Creates a charge via the Stripe API (`POST /v1/charges`)
4. Logs the result to a local `charge_log` table (success or failure)
5. Returns detailed charge information on success, or throws an error on failure

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `STRIPE_SECRET_KEY` | Your Stripe secret API key (starts with `sk_`) |

Get your API key from: https://dashboard.stripe.com/apikeys

## How to Use

### Running the Job

```bash
# Via Xano CLI
xano run run.xs --env STRIPE_SECRET_KEY=sk_test_...

# Or set the env var first
export STRIPE_SECRET_KEY=sk_test_...
xano run run.xs
```

### Customizing the Input

Edit `run.xs` to change the default input values:

```xs
run.job "Stripe Charge Customer" {
  main = {
    name: "charge_customer"
    input: {
      customer_id: "cus_your_customer_id"    // Stripe customer ID
      amount: 99.99                           // Amount in dollars (not cents!)
      currency: "usd"                         // 3-letter ISO currency code
      description: "Payment for services"     // Optional description
    }
  }
  env = ["STRIPE_SECRET_KEY"]
}
```

### Calling the Function Directly

You can also call the `charge_customer` function from other XanoScript code:

```xs
function "process_order" {
  input {
    text stripe_customer_id
    decimal order_total
  }
  stack {
    // Call the charge function
    function charge_customer {
      input = {
        customer_id: $input.stripe_customer_id,
        amount: $input.order_total,
        currency: "usd",
        description: "Order payment"
      }
    } as $charge_result
  }
  response = $charge_result
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `customer_id` | text | Yes | - | Stripe customer ID (e.g., `cus_xxx`) |
| `amount` | decimal | Yes | - | Charge amount in dollars (e.g., `50.00` = $50.00) |
| `currency` | text | No | `usd` | 3-letter ISO currency code |
| `description` | text | No | `""` | Optional description for the charge |

## Response

On success, returns:

```json
{
  "success": true,
  "charge_id": "ch_1N...",
  "status": "succeeded",
  "amount": 50.00,
  "currency": "usd",
  "customer": "cus_...",
  "receipt_url": "https://pay.stripe.com/receipts/...",
  "created": 1699999999
}
```

## Error Handling

The job handles these error scenarios:

- **Input validation errors** (400): Missing customer_id or invalid amount
- **Payment declined** (402): Card was declined by Stripe
- **Stripe API errors** (500): Other Stripe API failures

All attempts (success or failure) are logged to the `charge_log` table.

## File Structure

```
~/xs/stripe-charge-customer/
├── run.xs                    # Run job definition
├── function/
│   └── charge_customer.xs    # Main charge function
├── table/
│   └── charge_log.xs         # Table for logging charges
└── README.md                 # This file
```

## Testing

For testing, use Stripe's test mode API keys (start with `sk_test_`).

Stripe provides test card numbers:
- `4242 4242 4242 4242` - Successful charge
- `4000 0000 0000 0002` - Card declined
- See more at: https://stripe.com/docs/testing

## Security Notes

- Never commit your `STRIPE_SECRET_KEY` to version control
- Use environment variables or Xano's secret management
- The job validates inputs before calling Stripe
- All charge attempts are logged for audit purposes

## Links

- [Stripe API Docs](https://stripe.com/docs/api/charges/create)
- [Stripe Testing Guide](https://stripe.com/docs/testing)
