# Brex Create Expense Run Job

A XanoScript run job that creates a Brex expense for tracking business spending with optional receipt upload.

## What It Does

This run job creates a Brex expense record for business purchases:
1. **Creates an Expense** - Records merchant details, amount, category, and memo
2. **Optional Receipt Upload** - Attaches a receipt URL to the expense if provided

Perfect for tracking business expenses, SaaS subscriptions, travel costs, meals, and any company spending that needs to be categorized and reconciled.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `brex_api_token` | Your Brex API access token |

Get your API token from: https://dashboard.brex.com/settings/developers

**Security Note:** Keep your API token secure. Use environment variables or a secrets manager in production.

## How to Use

### 1. Set the Environment Variable

```bash
export brex_api_token="brx_prod_your_token_here"
```

### 2. Run the Job

Using the Xano CLI:
```bash
xano run execute
```

Or via the Run API.

### 3. Customize the Expense

Edit the `input` block in `run.xs` to customize:

```xs
run.job "Brex Create Expense" {
  main = {
    name: "brex_create_expense"
    input: {
      merchant_name: "Salesforce"
      amount: 2500.00
      currency: "USD"
      category: "software"
      memo: "Annual CRM subscription - Q1 renewal"
      purchase_date: "2026-02-13"
      receipt_url: "https://cdn.example.com/receipts/salesforce-2026.pdf"
    }
  }
  env = ["brex_api_token"]
}
```

## Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `merchant_name` | text | Yes | Name of the merchant/vendor |
| `amount` | decimal | Yes | Expense amount (positive number) |
| `currency` | text | No | 3-letter ISO currency code (default: `USD`) |
| `category` | text | No | Expense category (default: `uncategorized`) |
| `memo` | text | No | Description/note for the expense |
| `purchase_date` | date | No | Date of purchase (default: `now`) |
| `receipt_url` | text | No | URL to receipt image or document |

### Expense Categories

Common Brex expense categories include:
- `software` - SaaS subscriptions, licenses
- `meals` - Business meals and entertainment
- `travel` - Flights, hotels, transportation
- `office_supplies` - Stationery, equipment
- `marketing` - Ads, events, swag
- `utilities` - Internet, phone, services

## File Structure

```
brex-create-expense/
├── run.xs                              # Run job configuration
├── functions/
│   └── brex_create_expense.xs          # Function that calls Brex API
└── README.md                           # This file
```

## API Reference

This implementation uses the Brex Expenses API:

### Create Expense
- Endpoint: `POST https://platform.brexapis.com/v1/expenses`
- Documentation: https://developer.brex.com/docs/expenses/

### Upload Receipt
- Endpoint: `POST https://platform.brexapis.com/v1/expenses/{id}/receipt`
- Documentation: https://developer.brex.com/docs/expenses/#upload-receipt

## Response

On success, the function returns:

```json
{
  "success": true,
  "expense_id": "exp_abc123xyz789",
  "merchant_name": "AWS Services",
  "amount": 149.99,
  "currency": "USD",
  "category": "software",
  "memo": "Monthly EC2 and RDS hosting costs",
  "status": "submitted",
  "receipt_uploaded": false,
  "created_at": "2026-02-13T08:25:00Z",
  "brex_url": "https://dashboard.brex.com/expenses/exp_abc123xyz789"
}
```

## Error Handling

The function validates inputs and returns clear error messages for:
- Missing required fields (merchant_name, amount)
- Invalid amount (must be > 0)
- Brex API errors (invalid token, rate limits, etc.)

## Getting Started with Brex API

1. Sign up for a Brex account at https://brex.com
2. Go to Settings → Developers in your Brex dashboard
3. Generate an API token with `expenses:write` scope
4. Set the token as the `brex_api_token` environment variable

## License

MIT
