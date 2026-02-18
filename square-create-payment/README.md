# Square Create Payment - Xano Run Job

This Xano Run Job creates a payment using the Square API.

## What It Does

This run job processes a payment through Square's payment API. It:

1. Validates input parameters (source_id must be present, amount must be > 0)
2. Generates a unique idempotency key (required by Square)
3. Creates a payment via the Square API (`POST /v2/payments`)
4. Logs the result to a local `payment_log` table (success or failure)
5. Returns detailed payment information on success, or throws an error on failure

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SQUARE_ACCESS_TOKEN` | Your Square access token (starts with `EAAA` or `sq0atp-`) |
| `SQUARE_ENVIRONMENT` | Set to `sandbox` for testing or `production` for live payments |

Get your API credentials from: https://developer.squareup.com/apps

## How to Use

### Running the Job

```bash
# Via Xano CLI
xano run run.xs --env SQUARE_ACCESS_TOKEN=EAAA... --env SQUARE_ENVIRONMENT=sandbox

# Or set the env vars first
export SQUARE_ACCESS_TOKEN=EAAA...
export SQUARE_ENVIRONMENT=sandbox
xano run run.xs
```

### Customizing the Input

Edit `run.xs` to change the default input values:

```xs
run.job "Square Create Payment" {
  main = {
    name: "create_payment"
    input: {
      source_id: "cnon:card-nonce-ok"         // Square payment token/nonce
      amount: 99.99                           // Amount in dollars (not cents!)
      currency: "USD"                         // 3-letter ISO currency code
      note: "Payment for services"            // Optional note
      reference_id: "order-12345"             // Your internal order/reference ID
    }
  }
  env = ["SQUARE_ACCESS_TOKEN", "SQUARE_ENVIRONMENT"]
}
```

### Calling the Function Directly

You can also call the `create_payment` function from other XanoScript code:

```xs
function "process_order" {
  input {
    text square_token
    decimal order_total
    text order_id
  }
  stack {
    // Call the payment function
    function create_payment {
      input = {
        source_id: $input.square_token,
        amount: $input.order_total,
        currency: "USD",
        note: "Order payment",
        reference_id: $input.order_id
      }
    } as $payment_result
  }
  response = $payment_result
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `source_id` | text | Yes | - | Square payment token/nonce (e.g., `cnon:card-nonce-ok`) |
| `amount` | decimal | Yes | - | Payment amount in dollars (e.g., `50.00` = $50.00) |
| `currency` | text | No | `USD` | 3-letter ISO currency code (e.g., `USD`, `CAD`, `GBP`) |
| `note` | text | No | `""` | Optional note for the payment |
| `reference_id` | text | No | `""` | Your internal order/reference ID |

## Response

On success, returns:

```json
{
  "success": true,
  "payment_id": "hRjZzC...",
  "status": "COMPLETED",
  "amount": 50.00,
  "currency": "USD",
  "receipt_url": "https://squareup.com/receipt/...",
  "created_at": "2024-01-15T10:30:00.000Z"
}
```

## Error Handling

The job handles these error scenarios:

- **Input validation errors** (400): Missing source_id or invalid amount
- **Payment declined** (400): Card declined by Square
- **Authentication errors** (401): Invalid access token
- **Square API errors** (500): Other Square API failures

All attempts (success or failure) are logged to the `payment_log` table.

## File Structure

```
~/xs/square-create-payment/
├── run.xs                    # Run job definition
├── function/
│   └── create_payment.xs     # Main payment function
├── table/
│   └── payment_log.xs        # Table for logging payments
└── README.md                 # This file
```

## Testing

For testing, use Square's sandbox environment:

1. Create a Square Developer account at https://developer.squareup.com
2. Create a new application to get sandbox credentials
3. Set `SQUARE_ENVIRONMENT=sandbox`
4. Use Square's test card nonces:
   - `cnon:card-nonce-ok` - Successful payment
   - `cnon:card-nonce-declined` - Card declined
   - See more at: https://developer.squareup.com/docs/devtools/sandbox/payments

## Security Notes

- Never commit your `SQUARE_ACCESS_TOKEN` to version control
- Use environment variables or Xano's secret management
- Always use sandbox credentials for testing
- The job validates inputs before calling Square
- All payment attempts are logged for audit purposes

## Links

- [Square Payments API Docs](https://developer.squareup.com/reference/square/payments-api/create-payment)
- [Square Sandbox Testing](https://developer.squareup.com/docs/devtools/sandbox)
- [Square Test Card Nonces](https://developer.squareup.com/docs/devtools/sandbox/payments)
