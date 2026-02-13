# Shopify Create Customer

A Xano Run Job that creates new customers in a Shopify store via the Shopify Admin API.

## What It Does

This run job creates a new customer record in your Shopify store with:
- Email address
- First and last name
- Phone number (optional)
- Email verification status
- Optional email invite to activate their account

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `shopify_shop_domain` | Your Shopify store domain (e.g., `my-store.myshopify.com`) |
| `shopify_access_token` | Shopify Admin API access token with `write_customers` scope |

## Getting a Shopify Access Token

1. Go to your Shopify Admin → Settings → Apps and sales channels
2. Click "Develop apps" → "Create an app"
3. Name it and click "Create app"
4. Go to "Configuration" tab
5. Under "Admin API access scopes", enable `write_customers`
6. Save and install the app to your store
7. Go to "API credentials" tab and copy the "Admin API access token"

## How to Use

### Default Run (with sample data)
```bash
cd ~/xs/shopify-create-customer
xano run
```

### With Custom Input
Modify the `input` block in `run.xs`:

```xs
run.job "Shopify Create Customer" {
  main = {
    name: "create_customer"
    input: {
      email: "jane.smith@company.com"
      first_name: "Jane"
      last_name: "Smith"
      phone: "+1-555-123-4567"
      verified_email: true
      send_email_invite: true
    }
  }
  env = ["shopify_shop_domain", "shopify_access_token"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `email` | email | Yes | Customer's email address |
| `first_name` | text | Yes | Customer's first name |
| `last_name` | text | Yes | Customer's last name |
| `phone` | text | No | Customer's phone number (E.164 format recommended) |
| `verified_email` | boolean | No | Whether email is pre-verified (default: true) |
| `send_email_invite` | boolean | No | Send account activation email (default: false) |

## Response

On success, returns:

```json
{
  "success": true,
  "customer": {
    "id": 1234567890,
    "email": "customer@example.com",
    "first_name": "John",
    "last_name": "Doe",
    "phone": "+1234567890",
    "verified_email": true,
    "created_at": "2024-01-15T10:30:00Z"
  },
  "shop_domain": "my-store.myshopify.com"
}
```

## File Structure

```
shopify-create-customer/
├── run.xs              # Run job configuration
├── function/
│   └── create_customer.xs  # Customer creation logic
└── README.md           # This file
```

## API Reference

Uses Shopify REST Admin API v2024-01:
- Endpoint: `POST /admin/api/2024-01/customers.json`
- Docs: https://shopify.dev/docs/api/admin-rest/2024-01/resources/customer

## Error Handling

The job will fail with a clear error message if:
- Shopify credentials are invalid
- Customer email already exists
- Rate limits are exceeded
- Required fields are missing
