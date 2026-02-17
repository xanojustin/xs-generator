# Razorpay Create Order - Xano Run Job

This Xano Run Job creates a payment order using the Razorpay API. Razorpay is a popular payment gateway, especially in India, that enables businesses to accept payments online.

## What This Run Job Does

The `Razorpay Create Order` run job processes payment order creation by:
1. Accepting order details (amount, currency, receipt ID, notes)
2. Making an authenticated request to Razorpay's `/v1/orders` endpoint
3. Returning the created order object with details like order ID, amount, status, and payment links

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `razorpay_key_id` | Your Razorpay Key ID | `rzp_test_...` or `rzp_live_...` |
| `razorpay_key_secret` | Your Razorpay Key Secret | Generated from Razorpay Dashboard |

### Getting Your Razorpay API Credentials

1. Log in to your [Razorpay Dashboard](https://dashboard.razorpay.com)
2. Go to Settings → API Keys
3. Generate new keys (or view existing ones)
4. Copy your **Key ID** and **Key Secret**

**Note:** Use test keys (`rzp_test_...`) for development and live keys (`rzp_live_...`) for production.

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Razorpay Create Order"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Razorpay Create Order"
}
```

### Customizing the Order

Edit the `input` block in `run.xs`:

```xs
run.job "Razorpay Create Order" {
  main = {
    name: "create_razorpay_order"
    input: {
      amount: 100000              // Amount in paise (₹1000.00)
      currency: "INR"             // Currency code
      receipt: "ORDER-12345"      // Your internal receipt ID
      notes: {
        customer_name: "Jane Doe"
        customer_email: "jane@example.com"
        order_type: "subscription"
      }
    }
  }
  env = ["razorpay_key_id", "razorpay_key_secret"]
}
```

### Amount Format

Razorpay expects amounts in the **smallest currency unit**:
- For INR (₹): Amount in paise (100 paise = ₹1)
  - ₹500 = 50000
  - ₹1,000 = 100000
- For USD ($): Amount in cents (100 cents = $1)
  - $50 = 5000
  - $100 = 10000

## File Structure

```
razorpay-create-order/
├── run.xs                           # Run job configuration
├── function/
│   └── create_razorpay_order.xs     # Function that calls Razorpay API
└── README.md                        # This file
```

## Response Format

On success, the function returns a Razorpay Order object:

```json
{
  "id": "order_1A2B3C4D5E6F7G",
  "entity": "order",
  "amount": 50000,
  "amount_paid": 0,
  "amount_due": 50000,
  "currency": "INR",
  "receipt": "order_rcptid_11",
  "offer_id": null,
  "status": "created",
  "attempts": 0,
  "notes": {
    "customer_name": "John Doe",
    "customer_email": "john@example.com"
  },
  "created_at": 1623423456
}
```

### Response Fields

| Field | Description |
|-------|-------------|
| `id` | Unique order ID (e.g., `order_1A2B3C4D5E6F7G`) |
| `entity` | Entity type (always `"order"`) |
| `amount` | Order amount in smallest currency unit |
| `amount_paid` | Amount paid so far (0 for new orders) |
| `amount_due` | Remaining amount to be paid |
| `currency` | ISO currency code (e.g., `"INR"`) |
| `receipt` | Your internal receipt ID |
| `status` | Order status (`created`, `attempted`, `paid`) |
| `attempts` | Number of payment attempts |
| `notes` | Key-value pairs passed during creation |
| `created_at` | Unix timestamp of order creation |

## Error Handling

The function throws a `RazorpayAPIError` if:
- The Razorpay API returns a non-2xx status code
- The request times out
- Authentication fails (invalid credentials)
- The amount is below the minimum threshold

### Common Error Codes

| Status | Error | Description |
|--------|-------|-------------|
| 400 | Bad Request | Invalid parameters (e.g., amount too small) |
| 401 | Unauthorized | Invalid API credentials |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Razorpay server error |

## Security Notes

- **Never commit your Razorpay credentials** - always use environment variables
- Use test keys (`rzp_test_...`) during development
- Only use live keys (`rzp_live_...`) in production
- Store the order ID securely - you'll need it to verify payments
- Implement webhook handling to receive payment confirmations

## Next Steps After Order Creation

1. **Pass the order ID to your frontend** to complete payment using Razorpay Checkout
2. **Capture the payment** after successful completion (if manual capture is enabled)
3. **Verify the payment signature** to ensure authenticity
4. **Handle webhooks** for async payment status updates

## Additional Resources

- [Razorpay API Documentation](https://razorpay.com/docs/api/orders/)
- [Razorpay Checkout Integration](https://razorpay.com/docs/payments/payment-gateway/web-integration/standard/)
- [Razorpay Test Cards](https://razorpay.com/docs/payments/payments/test-card-details/)
- [XanoScript Documentation](https://docs.xano.com)