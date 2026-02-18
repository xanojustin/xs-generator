# QuickBooks Create Invoice - Xano Run Job

This Xano Run Job creates an invoice in QuickBooks Online.

## What It Does

This run job creates an invoice in QuickBooks Online using the QuickBooks API. It:

1. Validates input parameters (customer_id, customer_name must be present, at least one item required)
2. Builds line items for the invoice with support for up to 3 items
3. Calculates the total amount from line items
4. Creates the invoice via the QuickBooks API (`POST /v3/company/{realmId}/invoice`)
5. Logs the result to a local `invoice_log` table (success or failure)
6. Returns detailed invoice information on success, or throws an error on failure

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `QUICKBOOKS_ACCESS_TOKEN` | Your QuickBooks OAuth 2.0 access token |
| `QUICKBOOKS_REALM_ID` | Your QuickBooks company ID (found in URLs or settings) |

Get your credentials from: https://developer.intuit.com/

## How to Use

### Running the Job

```bash
# Via Xano CLI
xano run run.xs --env QUICKBOOKS_ACCESS_TOKEN=your_token --env QUICKBOOKS_REALM_ID=your_realm_id

# Or set the env vars first
export QUICKBOOKS_ACCESS_TOKEN=your_token
export QUICKBOOKS_REALM_ID=your_realm_id
xano run run.xs
```

### Customizing the Input

Edit `run.xs` to change the default input values:

```xs
run.job "QuickBooks Create Invoice" {
  main = {
    name: "create_invoice"
    input: {
      customer_id: "1"
      customer_name: "Acme Corporation"
      customer_email: "billing@acme.com"
      item_names: ["Consulting Services", "Software License"]
      item_amounts: [500.00, 299.99]
      item_descriptions: ["Monthly consulting retainer", "Annual software license"]
      item_quantities: [1, 1]
      invoice_date: ""
      due_date: ""
      memo: "Thank you for your business!"
    }
  }
  env = ["QUICKBOOKS_ACCESS_TOKEN", "QUICKBOOKS_REALM_ID"]
}
```

### Calling the Function Directly

You can also call the `create_invoice` function from other XanoScript code:

```xs
function "process_billing" {
  input {
    text qb_customer_id
    text qb_customer_name
    decimal service_amount
  }
  stack {
    // Call the invoice function
    function create_invoice {
      input = {
        customer_id: $input.qb_customer_id,
        customer_name: $input.qb_customer_name,
        customer_email: "customer@example.com",
        item_names: ["Services"],
        item_amounts: [$input.service_amount],
        item_descriptions: ["Professional services"],
        item_quantities: [1]
      }
    } as $invoice_result
  }
  response = $invoice_result
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `customer_id` | text | Yes | - | QuickBooks customer ID (e.g., `1`, `5`, etc.) |
| `customer_name` | text | Yes | - | Customer name for display/logging |
| `customer_email` | text | No | `""` | Customer email for invoice delivery |
| `item_names` | text[] | Yes | - | Array of item/service names |
| `item_amounts` | decimal[] | Yes | - | Array of amounts (must match item_names count) |
| `item_descriptions` | text[] | No | `[]` | Optional descriptions for each item |
| `item_quantities` | int[] | No | `[]` | Optional quantities (defaults to 1) |
| `invoice_date` | text | No | `now` | Invoice date (ISO format or timestamp) |
| `due_date` | text | No | `now` | Due date (ISO format or timestamp) |
| `memo` | text | No | `"Thank you for your business!"` | Customer-facing memo |

**Note:** Up to 3 line items are supported in the current implementation.

## Response

On success, returns:

```json
{
  "success": true,
  "invoice_id": "130",
  "doc_number": "1001",
  "customer_id": "1",
  "customer_name": "Acme Corporation",
  "total_amount": 799.99,
  "invoice_date": "2024-01-15T10:30:00Z",
  "due_date": "2024-02-15T10:30:00Z",
  "balance": 799.99,
  "invoice_status": "open",
  "view_invoice_url": "https://app.intuit.com/app/invoice?txnId=130",
  "created_at": "2024-01-15T10:30:00Z"
}
```

## Error Handling

The job handles these error scenarios:

- **Input validation errors** (400): Missing customer_id, customer_name, or invalid items
- **QuickBooks API errors** (4xx/5xx): Authentication failures, invalid customer IDs, etc.

All attempts (success or failure) are logged to the `invoice_log` table.

## File Structure

```
~/xs/quickbooks-create-invoice/
├── run.xs                    # Run job definition
├── function/
│   └── create_invoice.xs     # Main invoice creation function
├── table/
│   └── invoice_log.xs        # Table for logging invoices
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## Testing

For testing:
1. Use QuickBooks Sandbox environment: https://developer.intuit.com/app/developer/qbo/docs/develop/sandboxes
2. Create test customers in your sandbox company
3. Use test OAuth tokens from the QuickBooks Developer portal

## Security Notes

- Never commit your `QUICKBOOKS_ACCESS_TOKEN` or `QUICKBOOKS_REALM_ID` to version control
- Use environment variables or Xano's secret management
- The job validates inputs before calling QuickBooks
- All invoice attempts are logged for audit purposes
- QuickBooks access tokens expire; implement refresh token logic for production

## Links

- [QuickBooks API Docs](https://developer.intuit.com/app/developer/qbo/docs/api/accounting/all-entities/invoice)
- [QuickBooks OAuth 2.0 Guide](https://developer.intuit.com/app/developer/qbo/docs/develop/authentication-and-authorization/oauth-2.0)
- [QuickBooks Sandbox](https://developer.intuit.com/app/developer/qbo/docs/develop/sandboxes)
