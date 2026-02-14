# Plaid Exchange Token Run Job

This Xano run job exchanges a Plaid public token for a permanent access token, which can then be used to access financial data via Plaid's API.

## What It Does

The `exchange_token` function calls Plaid's `/item/public_token/exchange` endpoint to convert a temporary public token (obtained from Plaid Link) into a permanent access token.

## Required Environment Variables

Set these in your Xano workspace environment variables:

| Variable | Description | Example |
|----------|-------------|---------|
| `plaid_client_id` | Your Plaid client ID | `your-client-id` |
| `plaid_secret` | Your Plaid secret key | `your-secret-key` |
| `plaid_environment` | Plaid environment: `sandbox`, `development`, or `production` | `sandbox` |

## How to Use

### Run the Job

The run job is configured in `run.xs` with a default public token. Update the input in `run.xs` or call the function directly with your public token.

### Function Input

```xs
{
  public_token: "public-sandbox-123456"  // The public token from Plaid Link
}
```

### Function Response

On success:
```json
{
  "success": true,
  "access_token": "access-sandbox-xxx",
  "item_id": "item-sandbox-yyy"
}
```

On error:
```json
{
  "success": false,
  "error": "Error message from Plaid",
  "status_code": 400
}
```

## File Structure

```
plaid-exchange-token/
├── run.xs              # Run job configuration
├── function/
│   └── exchange_token.xs  # Token exchange logic
└── README.md           # This file
```

## Plaid API Documentation

- [Plaid Quickstart](https://plaid.com/docs/quickstart/)
- [Exchange Token Endpoint](https://plaid.com/docs/api/items/#itempublic_tokenexchange)

## Notes

- The public token is single-use and expires after 30 minutes
- The access token is permanent and should be stored securely
- Access tokens are unique to the `item` (bank account connection)
