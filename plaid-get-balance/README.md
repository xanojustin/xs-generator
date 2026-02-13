# Plaid Get Account Balances

A Xano Run Job that retrieves account balances from connected bank accounts using the Plaid API.

## What This Run Job Does

This run job connects to the Plaid API and retrieves real-time balance information for all accounts associated with a given access token. It provides:

- Current and available balances for each account
- Account details (name, type, subtype, mask)
- Total balance across all accounts
- Support for both Plaid Sandbox and Production environments

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `plaid_client_id` | Your Plaid client ID (from Plaid Dashboard) |
| `plaid_secret` | Your Plaid secret key (from Plaid Dashboard) |

## How to Use

### 1. Get Plaid Credentials

1. Sign up at [https://dashboard.plaid.com](https://dashboard.plaid.com)
2. Get your `client_id` and `secret` from the dashboard
3. Set these as environment variables in your Xano workspace

### 2. Obtain an Access Token

Before using this run job, you need an access token from Plaid Link:

1. Use Plaid Link to connect a bank account
2. Exchange the public token for an access token
3. Store the access token securely

### 3. Run the Job

Update the `run.xs` with your access token:

```xs
run.job "Plaid Get Account Balances" {
  main = {
    name: "plaid_get_balance"
    input: {
      access_token: "access-production-xxxxxx"  // Your actual access token
      plaid_environment: "production"           // or "sandbox" for testing
    }
  }
  env = ["plaid_client_id", "plaid_secret"]
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `access_token` | text | Yes | Plaid access token for the connected account |
| `plaid_environment` | text | No | `"sandbox"` (default) or `"production"` |

### Response

```json
{
  "success": true,
  "item_id": "item_xxxxxxxxxx",
  "institution_id": "ins_xxxxxx",
  "accounts": [
    {
      "account_id": "xxxxxxxxxxx",
      "name": "Checking Account",
      "type": "depository",
      "subtype": "checking",
      "mask": "1234",
      "current_balance": 1250.50,
      "available_balance": 1200.00,
      "currency": "USD"
    }
  ],
  "total_balance": 1250.50,
  "account_count": 1
}
```

## File Structure

```
plaid-get-balance/
├── run.xs                          # Run job configuration
├── functions/
│   └── plaid_get_balance.xs       # Main function implementation
└── README.md                       # This file
```

## API Reference

This run job uses the Plaid `/accounts/balance/get` endpoint:
- Documentation: https://plaid.com/docs/api/accounts/#accountsbalanceget
- Rate limits apply based on your Plaid plan

## Testing

For testing without real bank accounts:
1. Use Plaid Sandbox environment
2. Use sandbox credentials from Plaid documentation
3. Test accounts with pre-defined balances are available

## Security Notes

- Never commit real access tokens to version control
- Access tokens are sensitive - store them securely
- Use environment variables for all credentials
- Rotate your Plaid secrets periodically
