# QuickBooks Create Invoice Run Job

This Xano Run Job creates a new invoice in QuickBooks Online using the QuickBooks Accounting API.

## What This Run Job Does

This run job creates a professional invoice in QuickBooks Online with:
- Customer information (name and email)
- Multiple line items with quantities and prices
- Automatic total calculation
- Due date tracking
- Proper error handling for API responses

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `quickbooks_access_token` | OAuth 2.0 access token from QuickBooks | `eyJraWQ...` |
| `quickbooks_realm_id` | Your QuickBooks company ID | `1234567890` |
| `quickbooks_environment` | API environment to use | `sandbox` or `production` |

## Getting QuickBooks Credentials

1. Create a QuickBooks Developer account at [developer.intuit.com](https://developer.intuit.com)
2. Create a new app to get your Client ID and Client Secret
3. Use the OAuth 2.0 flow to obtain an access token
4. Get your Realm ID (Company ID) from your QuickBooks account

## How to Use

### Default Usage
The run job comes with sample data that creates an invoice for "Acme Corp" with two line items:
- 2x Consulting Services @ $500.00 each
- 1x Software License @ $299.99

### Customizing Input

Edit the `input` block in `run.xs` to customize:

```xs
main = {
  name: "create_invoice"
  input: {
    customer_name: "Your Customer Name"
    customer_email: "customer@example.com"
    line_items: [
      {
        description: "Service Description"
        amount: 100.00
        quantity: 1
      }
    ]
    due_date: "2026-12-31"
  }
}
```

### Running the Job

Via Xano CLI:
```bash
xano run --job quickbooks-create-invoice
```

Via Xano Run API:
```bash
curl -X POST https://app.dev.xano.com/api:run/quickbooks-create-invoice \
  -H "Authorization: Bearer YOUR_TOKEN"
```

## Output

On success, the job returns:
```json
{
  "success": true,
  "invoice_id": "123",
  "invoice_number": "1001",
  "total_amount": 1299.99,
  "customer": "Acme Corp",
  "due_date": "2026-03-15",
  "quickbooks_response": { ... }
}
```

## Error Handling

The run job handles common QuickBooks API errors:
- **400 Bad Request**: Invalid invoice data
- **401 Unauthorized**: Expired or invalid access token
- **403 Forbidden**: Incorrect realm ID or insufficient permissions
- **Other errors**: Returns detailed error messages

## API Reference

- [QuickBooks Accounting API Documentation](https://developer.intuit.com/app/developer/qbo/docs/api/accounting/most-popular/invoice)
- [QuickBooks OAuth 2.0 Guide](https://developer.intuit.com/app/developer/qbo/docs/develop/authentication-and-authorization/oauth-2.0)

## File Structure

```
quickbooks-create-invoice/
├── run.xs                      # Run job configuration
├── function/
│   └── create_invoice.xs       # Main function that calls QuickBooks API
├── README.md                   # This file
└── FEEDBACK.md                 # Development feedback for MCP improvements
```
