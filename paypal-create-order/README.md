# PayPal Create Order - Xano Run Job

This Xano Run Job creates a payment order using the PayPal REST API. It demonstrates how to integrate with PayPal's payment processing service from Xano.

## What This Run Job Does

The `PayPal Create Order` run job processes a payment order by:
1. Authenticating with PayPal using OAuth 2.0 client credentials
2. Obtaining an access token from PayPal's `/v1/oauth2/token` endpoint
3. Creating a new order via PayPal's `/v2/checkout/orders` endpoint
4. Returning the created order object with details like order ID, status, and approval URL

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `paypal_client_id` | Your PayPal Client ID | `AZ_...` (Sandbox) or `AaA...` (Live) |
| `paypal_client_secret` | Your PayPal Client Secret | `EJ_...` (Sandbox) or `EH_...` (Live) |

### Getting Your PayPal API Credentials

1. Log in to your [PayPal Developer Dashboard](https://developer.paypal.com)
2. Go to **Apps & Credentials**
3. Under **REST API apps**, click **Create App** or select an existing app
4. Copy your **Client ID** and **Secret**
5. Toggle between **Sandbox** and **Live** modes as needed

**Note**: PayPal uses separate credentials for Sandbox (testing) and Live (production) environments.

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "PayPal Create Order"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "PayPal Create Order"
}
```

### Customizing the Order

Edit the `input` block in `run.xs`:

```xs
run.job "PayPal Create Order" {
  main = {
    name: "paypal_order"
    input: {
      intent: "CAPTURE"
      purchase_units: [
        {
          amount: {
            currency_code: "USD"
            value: "100.00"
          }
          description: "Payment for Order #12345"
        }
      ]
    }
  }
  env = ["paypal_client_id", "paypal_client_secret"]
}
```

### Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `intent` | text | Order intent - `'CAPTURE'` (immediate capture) or `'AUTHORIZE'` (authorize now, capture later) |
| `purchase_units` | json | Array of purchase units containing amount and description |

### Purchase Unit Structure

```json
{
  "amount": {
    "currency_code": "USD",
    "value": "50.00"
  },
  "description": "Payment description"
}
```

**Supported Currency Codes**: USD, EUR, GBP, CAD, AUD, JPY, and many more. See [PayPal's documentation](https://developer.paypal.com/docs/api/reference/currency-codes/) for the full list.

## File Structure

```
paypal-create-order/
├── run.xs                    # Run job configuration
├── function/
│   └── paypal_order.xs       # Function that calls PayPal API
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## Response Format

On success, the function returns a PayPal Order object:

```json
{
  "id": "5O190127TN364715T",
  "intent": "CAPTURE",
  "status": "CREATED",
  "purchase_units": [
    {
      "reference_id": "default",
      "amount": {
        "currency_code": "USD",
        "value": "50.00"
      },
      "description": "Order from Xano Run Job",
      "payee": {
        "email_address": "merchant@example.com",
        "merchant_id": "MERCHANT123"
      }
    }
  ],
  "create_time": "2024-01-15T10:30:00Z",
  "links": [
    {
      "href": "https://api.paypal.com/v2/checkout/orders/5O190127TN364715T",
      "rel": "self",
      "method": "GET"
    },
    {
      "href": "https://www.paypal.com/checkoutnow?token=5O190127TN364715T",
      "rel": "approve",
      "method": "GET"
    },
    {
      "href": "https://api.paypal.com/v2/checkout/orders/5O190127TN364715T",
      "rel": "update",
      "method": "PATCH"
    },
    {
      "href": "https://api.paypal.com/v2/checkout/orders/5O190127TN364715T/capture",
      "rel": "capture",
      "method": "POST"
    }
  ]
}
```

### Response Fields

| Field | Description |
|-------|-------------|
| `id` | Unique PayPal order ID |
| `intent` | Order intent (CAPTURE or AUTHORIZE) |
| `status` | Order status: `CREATED`, `SAVED`, `APPROVED`, `VOIDED`, `COMPLETED`, or `PAYER_ACTION_REQUIRED` |
| `purchase_units` | Array of purchase units with amount details |
| `create_time` | ISO 8601 timestamp of order creation |
| `links` | HATEOAS links including the approval URL (rel: "approve") |

## Order Status Flow

1. **CREATED** - Order created, waiting for customer approval
2. **SAVED** - Order saved but not yet approved
3. **APPROVED** - Customer approved the payment
4. **COMPLETED** - Payment captured successfully
5. **VOIDED** - Order cancelled or expired

## Error Handling

The function throws a `PayPalAuthError` if authentication fails (invalid credentials).

The function throws a `PayPalOrderError` if:
- The PayPal API returns a non-201 status code
- The request is malformed
- Currency code is invalid
- Amount format is incorrect

Common error codes:
- `401 Unauthorized` - Invalid Client ID or Secret
- `400 Bad Request` - Invalid request parameters
- `422 Unprocessable Entity` - Validation error (invalid amount, currency, etc.)

## Security Notes

- **Never commit your PayPal credentials** - always use environment variables
- Use **Sandbox** credentials during development
- Only use **Live** credentials in production
- Store credentials securely in Xano's environment variable management
- Rotate your API credentials periodically
- Monitor your PayPal Developer Dashboard for API usage

## Next Steps After Order Creation

1. **Redirect Customer to PayPal**
   - Use the `approve` link from the response
   - Redirect the customer to complete payment

2. **Capture the Order**
   - After customer approval, call `POST /v2/checkout/orders/{id}/capture`
   - See [PayPal's capture documentation](https://developer.paypal.com/docs/api/orders/v2/#orders_capture)

3. **Handle Webhooks**
   - Set up webhooks to receive async payment notifications
   - Handle `CHECKOUT.ORDER.APPROVED` and `CHECKOUT.ORDER.COMPLETED` events

## Testing

PayPal provides a [Sandbox environment](https://developer.paypal.com/tools/sandbox/) for testing:

1. Create a Sandbox Business account (as seller)
2. Create a Sandbox Personal account (as buyer)
3. Use Sandbox credentials in your Xano environment
4. Complete test transactions without real money

### Test Credit Cards (Sandbox)

| Card Type | Number | Expiry | CVV |
|-----------|--------|--------|-----|
| Visa | 4032035177293828 | 01/2026 | 123 |
| Mastercard | 5424180011112226 | 01/2026 | 123 |
| Amex | 3741113334446111 | 01/2026 | 1234 |

## Additional Resources

- [PayPal Orders API v2](https://developer.paypal.com/docs/api/orders/v2/)
- [PayPal REST API Authentication](https://developer.paypal.com/api/rest/authentication/)
- [PayPal Checkout Integration Guide](https://developer.paypal.com/docs/checkout/)
- [PayPal Sandbox Testing](https://developer.paypal.com/tools/sandbox/)
- [XanoScript Documentation](https://docs.xano.com)

## Limitations

- The function creates the order but doesn't handle the approval/capture flow
- Custom shipping and billing details are not included in the basic implementation
- Item-level details (line items) are not included
- No support for PayPal's advanced features (subscriptions, invoicing, etc.)
