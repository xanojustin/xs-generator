# Square Process Payment - Xano Run Job

This Xano Run Job processes payments using the Square Payments API. It creates a payment charge with a specified amount, currency, and payment source.

## What This Run Job Does

1. Accepts payment details (amount, currency, payment source)
2. Generates an idempotency key to prevent duplicate charges
3. Calls the Square Payments API to process the payment
4. Returns the payment result with status and details

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `SQUARE_ACCESS_TOKEN` | Your Square API access token | Yes |
| `SQUARE_ENVIRONMENT` | Set to `sandbox` or `production` | Yes |

## Getting Square Credentials

1. Sign up at [Square Developer](https://developer.squareup.com/)
2. Create a new application in the Developer Dashboard
3. Copy your **Sandbox Access Token** for testing
4. For production, request production credentials

## Usage

### Default Input Values

The run job comes with default test values:
- **amount**: `1000` ($10.00 in cents)
- **currency**: `"USD"`
- **source_id**: `"cnon:card-nonce-ok"` (Square's test nonce)
- **note**: `"Test payment via Xano Run Job"`

### Custom Input

You can override any input value:

```xs
run.job "Process Square Payment" {
  main = {
    name: "process_square_payment"
    input: {
      amount: 2500
      currency: "USD"
      source_id: "your-card-nonce-here"
      note: "Payment for Order #12345"
    }
  }
  env = ["SQUARE_ACCESS_TOKEN", "SQUARE_ENVIRONMENT"]
}
```

### Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `amount` | int | 1000 | Amount in cents (e.g., 1000 = $10.00) |
| `currency` | text | "USD" | ISO currency code |
| `source_id` | text | "cnon:card-nonce-ok" | Square payment source (card nonce or token) |
| `idempotency_key` | text | "" | Unique key for idempotency (auto-generated if empty) |
| `note` | text | "" | Optional note attached to the payment |

## Response

The function returns a result object:

```json
{
  "status": "success",
  "message": "Payment processed successfully",
  "payment": {
    "payment": {
      "id": "payment-id-here",
      "status": "COMPLETED",
      "amount_money": {
        "amount": 1000,
        "currency": "USD"
      },
      ...
    }
  },
  "idempotency_key": "xano-uuid-here",
  "request_details": {
    "amount": 1000,
    "currency": "USD",
    "environment": "sandbox"
  }
}
```

## Test Card Nonces

Square provides test card nonces for sandbox testing:

| Nonce | Description |
|-------|-------------|
| `cnon:card-nonce-ok` | Successful payment |
| `cnon:card-nonce-declined` | Declined payment |
| `cnon:card-nonce-insufficient-funds` | Insufficient funds |

## API Documentation

- [Square Payments API](https://developer.squareup.com/reference/square/payments-api/create-payment)
- [Square Sandbox Testing](https://developer.squareup.com/docs/devtools/sandbox/overview)

## File Structure

```
square-process-payment/
├── run.xs                          # Run job configuration
├── function/
│   └── process_square_payment.xs   # Payment processing function
└── README.md                       # This file
```

## Error Handling

The function handles common Square API errors:
- **401**: Authentication failed (invalid token)
- **400**: Bad request (invalid parameters)
- **Other**: General API errors

Errors are returned with a descriptive message and null payment data.