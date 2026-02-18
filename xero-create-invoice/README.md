# Xero Create Invoice - Xano Run Job

This Xano Run Job creates invoices in [Xero](https://www.xero.com/), a popular cloud-based accounting software for small and medium businesses.

## What This Run Job Does

Creates a new invoice in Xero with support for:
- Customer contact information (name and email)
- Line items with descriptions, quantities, and pricing
- Configurable invoice dates and due dates
- Multiple invoice types (Accounts Receivable, Accounts Payable)
- Multiple invoice statuses (Draft, Submitted, Authorised)
- Automatic total calculations

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `XERO_ACCESS_TOKEN` | Your Xero OAuth 2.0 access token |

### Getting a Xero Access Token

1. Create a Xero app at https://developer.xero.com/myapps
2. Complete the OAuth 2.0 flow to obtain an access token
3. Set the token as an environment variable in Xano

**Note:** Xero access tokens expire after 30 minutes. For production use, implement token refresh logic.

## Required Input Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `tenant_id` | text | Your Xero organization ID (found in Xero Settings > General Settings > Organization Details) |
| `contact_name` | text | Customer name to appear on the invoice |
| `description` | text | Description of the line item |
| `quantity` | decimal | Quantity of the item |
| `unit_amount` | decimal | Price per unit |

## Optional Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `contact_email` | text | - | Customer email address |
| `account_code` | text | "200" | Xero account code (200 = Sales) |
| `invoice_type` | text | "ACCREC" | Invoice type: ACCREC (Customer) or ACCPAY (Supplier) |
| `invoice_status` | text | "DRAFT" | Status: DRAFT, SUBMITTED, or AUTHORISED |
| `date` | text | Today | Invoice date (YYYY-MM-DD format) |
| `due_date` | text | +30 days | Due date (YYYY-MM-DD format) |

## Response

On success, returns:

```json
{
  "success": true,
  "invoice_id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "invoice_number": "INV-0001",
  "status": "DRAFT",
  "total": 100.00,
  "amount_due": 100.00,
  "date": "2025-02-18",
  "due_date": "2025-03-20",
  "contact_name": "Acme Corp",
  "line_items_count": 1
}
```

## Error Handling

The run job handles common Xero API errors:

- **400** - Validation errors (invalid data format)
- **401** - Authentication failure (invalid or expired token)
- **403** - Access denied (wrong tenant ID)
- **429** - Rate limit exceeded
- **500+** - Xero server errors

## Example Usage

### Basic Invoice

```json
{
  "tenant_id": "your-tenant-id",
  "contact_name": "Acme Corporation",
  "description": "Consulting Services",
  "quantity": 10,
  "unit_amount": 150.00
}
```

### With Email and Custom Dates

```json
{
  "tenant_id": "your-tenant-id",
  "contact_name": "Acme Corporation",
  "contact_email": "billing@acme.com",
  "description": "Monthly Subscription",
  "quantity": 1,
  "unit_amount": 499.99,
  "account_code": "200",
  "invoice_status": "AUTHORISED",
  "date": "2025-02-18",
  "due_date": "2025-03-18"
}
```

## File Structure

```
xero-create-invoice/
├── run.xs                    # Run job configuration
├── function/
│   └── create_xero_invoice.xs  # Main function logic
└── README.md                 # This file
```

## API Reference

- [Xero Accounting API Documentation](https://developer.xero.com/documentation/api/accounting/invoices)
- [Xero OAuth 2.0 Guide](https://developer.xero.com/documentation/guides/oauth2/overview)

## Notes

- Xero uses OAuth 2.0 for authentication
- Each request requires a valid `Xero-tenant-id` header
- The tenant ID identifies which Xero organization to create the invoice in
- Invoices created as DRAFT won't be visible to customers until authorised
