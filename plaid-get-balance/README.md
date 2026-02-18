# Plaid Get Account Balance - Xano Run Job

This Xano Run Job exchanges a Plaid public token for an access token and retrieves account balance information.

## What It Does

This run job integrates with the Plaid API to:

1. **Exchange Public Token**: Converts a temporary public token (from Plaid Link) into a persistent access token
2. **Fetch Account Balances**: Uses the access token to retrieve current balance information for all linked accounts
3. **Log Operations**: Records all API operations (success or failure) to a local `plaid_log` table for audit purposes
4. **Return Structured Data**: Returns account details including balances, account types, and institution information

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `PLAID_CLIENT_ID` | Your Plaid client ID (from Plaid Dashboard) |
| `PLAID_SECRET` | Your Plaid secret key (sandbox, development, or production) |
| `PLAID_ENV` | Environment: `sandbox`, `development`, or `production` |

Get your credentials from: https://dashboard.plaid.com/team/keys

## How to Use

### Running the Job

```bash
# Via Xano CLI with all environment variables
xano run run.xs --env PLAID_CLIENT_ID=your_client_id --env PLAID_SECRET=your_secret --env PLAID_ENV=sandbox

# Or set env vars first
export PLAID_CLIENT_ID=your_client_id
export PLAID_SECRET=your_secret
export PLAID_ENV=sandbox
xano run run.xs
```

### Obtaining a Public Token

Before running this job, you need a public token from Plaid Link:

```bash
# Create a public token via Plaid API (for testing)
curl -X POST https://sandbox.plaid.com/sandbox/public_token/create \
  -H "Content-Type: application/json" \
  -d '{
    "client_id": "your_client_id",
    "secret": "your_secret",
    "institution_id": "ins_109508",  # Chase bank
    "initial_products": ["transactions", "auth"]
  }'
```

### Customizing the Input

Edit `run.xs` to change the default input values:

```xs
run.job "Plaid Get Account Balance" {
  main = {
    name: "exchange_and_get_balance"
    input: {
      public_token: "public-sandbox-xxx"  // Your public token from Plaid Link
    }
  }
  env = ["PLAID_CLIENT_ID", "PLAID_SECRET", "PLAID_ENV"]
}
```

### Calling the Function Directly

You can also call the `exchange_and_get_balance` function from other XanoScript code:

```xs
function "process_bank_accounts" {
  input {
    text plaid_public_token
  }
  stack {
    // Get account balances
    function.run "exchange_and_get_balance" {
      input = {
        public_token: $input.plaid_public_token
      }
    } as $balance_result
  }
  response = $balance_result
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `public_token` | text | Yes | - | Plaid public token (from Plaid Link) |

## Response

On success, returns:

```json
{
  "success": true,
  "item_id": "item-sandbox-xxx",
  "accounts": [
    {
      "account_id": "account-sandbox-xxx",
      "balances": {
        "available": 100.00,
        "current": 110.00,
        "limit": null,
        "iso_currency_code": "USD",
        "unofficial_currency_code": null
      },
      "mask": "0000",
      "name": "Plaid Checking",
      "official_name": "Plaid Gold Standard 0% Interest Checking",
      "subtype": "checking",
      "type": "depository"
    }
  ]
}
```

### Account Types

| Type | Description |
|------|-------------|
| `depository` | Checking and savings accounts |
| `credit` | Credit cards and lines of credit |
| `loan` | Mortgages, auto loans, student loans |
| `investment` | Brokerage, 401k, IRA accounts |
| `other` | Other account types |

## Error Handling

The job handles these error scenarios:

- **Input validation errors** (400): Missing public_token
- **Token exchange errors** (401/400): Invalid or expired public token
- **Balance fetch errors** (400/401): Invalid access token or API errors
- **Plaid API errors** (500): Other Plaid API failures

All operations (success or failure) are logged to the `plaid_log` table.

## File Structure

```
~/xs/plaid-get-balance/
├── run.xs                              # Run job definition
├── function/
│   └── exchange_and_get_balance.xs     # Main function
├── table/
│   └── plaid_log.xs                    # Table for logging operations
└── README.md                           # This file
```

## Testing

For testing, use Plaid's Sandbox environment:

1. Set `PLAID_ENV=sandbox` in your environment
2. Use sandbox credentials from Plaid Dashboard
3. Create public tokens using the `/sandbox/public_token/create` endpoint
4. Sandbox accounts have predictable data for testing

### Sandbox Institution IDs

- `ins_109508` - Chase Bank
- `ins_109509` - Bank of America
- `ins_109510` - Wells Fargo
- `ins_109511` - Citi Bank

See more at: https://plaid.com/docs/sandbox/

## Security Notes

- Never commit your `PLAID_SECRET` to version control
- Use environment variables or Xano's secret management
- Public tokens are single-use and expire after 30 minutes
- Access tokens are long-lived and should be stored securely
- All API operations are logged for audit purposes

## Links

- [Plaid API Docs](https://plaid.com/docs/api/)
- [Plaid Quickstart](https://plaid.com/docs/quickstart/)
- [Sandbox Testing](https://plaid.com/docs/sandbox/)
- [Plaid Dashboard](https://dashboard.plaid.com/)
