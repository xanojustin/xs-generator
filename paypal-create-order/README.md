# PayPal Create Order Run Job

This XanoScript run job creates a PayPal order for payment processing using the PayPal Checkout API.

## What It Does

This run job creates a PayPal order that customers can pay for. It handles:

- Authenticating with PayPal OAuth 2.0
- Creating an order with specified amount and currency
- Configuring return and cancel URLs for the checkout flow
- Returning the order ID and approval URL for redirecting the customer

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `PAYPAL_CLIENT_ID` | Your PayPal REST API Client ID |
| `PAYPAL_CLIENT_SECRET` | Your PayPal REST API Secret |
| `PAYPAL_BASE_URL` | PayPal API base URL. Use `https://api.sandbox.paypal.com` for sandbox/testing or `https://api.paypal.com` for production |

## Getting PayPal Credentials

1. Log in to the [PayPal Developer Dashboard](https://developer.paypal.com/)
2. Create a new app or use an existing one
3. Copy the Client ID and Secret from your app
4. For testing, use the sandbox credentials

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `amount` | text | Yes | Order amount (e.g., `10.00` for $10.00) |
| `currency` | text | No | Currency code (default: `USD`) |
| `description` | text | No | Description of the order |
| `return_url` | text | Yes | URL to redirect customer after successful payment |
| `cancel_url` | text | Yes | URL to redirect customer if they cancel payment |
| `brand_name` | text | No | Business name to display on PayPal checkout page |

### Response

```json
{
  "success": true,
  "order_id": "5O190127TN364715T",
  "status": "CREATED",
  "approve_url": "https://www.paypal.com/checkoutnow?token=5O190127TN364715T",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "order_id": null,
  "status": null,
  "approve_url": null,
  "error": "The requested action could not be performed..."
}
```

## File Structure

```
paypal-create-order/
├── run.xs                    # Run job definition
├── function/
│   └── create_order.xs       # Function to create PayPal order
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## PayPal API Reference

- [Orders API v2](https://developer.paypal.com/docs/api/orders/v2/)
- [OAuth 2.0 Authentication](https://developer.paypal.com/docs/api/reference/api-requests/#authentication)
- [Checkout SDK Integration](https://developer.paypal.com/docs/checkout/standard/integrate/)

## Testing

Use PayPal's sandbox environment for testing:

1. Set `PAYPAL_BASE_URL` to `https://api.sandbox.paypal.com`
2. Use sandbox Client ID and Secret from your PayPal Developer account
3. Use [sandbox test accounts](https://developer.paypal.com/dashboard/accounts) for testing payments

### Sandbox Test Credit Cards

- Visa: `4032035400845969` (any future expiry, any CVV)
- Mastercard: `5406009481263516` (any future expiry, any CVV)

## Security Notes

- Never commit your `PAYPAL_CLIENT_SECRET` to version control
- Use sandbox credentials during development
- Store production credentials securely
- The Client Secret should be treated like a password

## Next Steps After Order Creation

1. Redirect the customer to the `approve_url` returned in the response
2. Customer completes payment on PayPal
3. PayPal redirects customer to your `return_url`
4. Capture the order using the order ID (separate API call)
5. Fulfill the order
