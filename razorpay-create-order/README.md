# Razorpay Create Order Run Job

This XanoScript run job creates a payment order using the Razorpay API. Orders in Razorpay are used to initiate payments that customers can complete.

## What It Does

This run job creates a Razorpay Order which:
- Defines the payment amount and currency
- Generates a unique order ID for tracking
- Sets up receipt identifiers for your records
- Attaches custom metadata notes
- Returns the order details for payment processing

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `RAZORPAY_KEY_ID` | Your Razorpay Key ID (starts with `rzp_`) |
| `RAZORPAY_KEY_SECRET` | Your Razorpay Key Secret |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `amount` | text | Yes | Amount to charge in smallest currency unit (e.g., `2000` for ₹20.00) |
| `currency` | text | No | Currency code (default: `INR`) |
| `receipt` | text | No | Receipt identifier for internal tracking |
| `notes` | json | No | Key-value pairs for additional metadata |

### Response

```json
{
  "success": true,
  "order_id": "order_1234567890abcdef",
  "status": "created",
  "amount_paid": 0,
  "amount_due": 2000,
  "created_at": 1707811200,
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "order_id": null,
  "status": null,
  "amount_paid": null,
  "amount_due": null,
  "created_at": null,
  "error": "BAD_REQUEST_ERROR - The amount must be at least 100 (INR 1.00)"
}
```

## File Structure

```
razorpay-create-order/
├── run.xs                    # Run job definition
├── function/
│   └── create_order.xs       # Function to create order
├── README.md                 # This file
└── FEEDBACK.md               # MCP/XanoScript feedback
```

## Razorpay API Reference

- [Orders API](https://razorpay.com/docs/api/orders/)
- [Authentication](https://razorpay.com/docs/api/authentication/)

## Testing

Use Razorpay's test mode credentials for development:
1. Switch to Test Mode in your Razorpay Dashboard
2. Copy the Test Key ID and Secret
3. Set them as environment variables

### Test Card Numbers

For completing payments on created orders:
- `5267 3181 8797 5449` - Mastercard (successful payment)
- `4111 1111 1111 1111` - Visa (successful payment)
- `4000 0000 0000 0002` - Card declined

## Payment Flow

1. **Create Order** (this run job) → Returns order_id
2. **Pass order_id to your frontend** → Customer completes payment
3. **Verify payment signature** → Confirm successful payment
4. **Capture payment** (if manual capture enabled)

## Security Notes

- Never commit your `RAZORPAY_KEY_ID` or `RAZORPAY_KEY_SECRET` to version control
- Use Razorpay's test mode during development
- Implement webhook signature verification in production
- The minimum order amount for INR is 100 (₹1.00)

## Currency Support

Razorpay supports multiple currencies including:
- `INR` - Indian Rupee (default)
- `USD` - US Dollar
- `EUR` - Euro
- `GBP` - British Pound
- `AUD` - Australian Dollar
- And many more...

Note: Currency support depends on your Razorpay account configuration.
