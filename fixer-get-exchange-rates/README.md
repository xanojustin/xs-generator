# Fixer.io Exchange Rate Fetcher

A Xano Run Job that fetches the latest currency exchange rates from the Fixer.io API.

## What This Run Job Does

This run job connects to the Fixer.io API to retrieve real-time currency exchange rates. It fetches rates for multiple target currencies relative to a base currency (default: USD).

### Features

- Fetches latest exchange rates from Fixer.io
- Configurable base currency (defaults to USD)
- Configurable target currencies list
- Proper error handling for API failures
- Validates API key configuration
- Returns structured response with rates, timestamp, and date

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `FIXER_API_KEY` | Your Fixer.io API access key | Yes |

### Getting a Fixer API Key

1. Sign up at [Fixer.io](https://fixer.io/)
2. Subscribe to a plan (free tier available)
3. Copy your API access key from the dashboard
4. Add it as an environment variable in Xano: `FIXER_API_KEY`

## How to Use

### Basic Usage (Default Settings)

The run job comes pre-configured with sensible defaults:
- Base currency: USD
- Target currencies: EUR, GBP, JPY, CAD, AUD

### Customizing Input Parameters

Edit the `run.xs` file to change the input parameters:

```xs
run.job "Fixer Exchange Rate Fetcher" {
  main = {
    name: "fetch_exchange_rates"
    input: {
      base_currency: "EUR"           // Change base currency
      target_currencies: ["USD", "GBP", "JPY"]  // Change target currencies
    }
  }
  env = ["FIXER_API_KEY"]
}
```

### Function Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `base_currency` | text | "USD" | The base currency code (e.g., USD, EUR, GBP) |
| `target_currencies` | text[] | ["EUR", "GBP", "JPY", "CAD", "AUD"] | Array of target currency codes to fetch rates for |

### Response Format

On success, the function returns:

```json
{
  "success": true,
  "base": "USD",
  "date": "2024-01-15",
  "timestamp": 1705315200,
  "rates": {
    "EUR": 0.9123,
    "GBP": 0.7845,
    "JPY": 148.23,
    "CAD": 1.3456,
    "AUD": 1.5234
  }
}
```

## File Structure

```
fixer-get-exchange-rates/
├── run.xs                      # Run job configuration
├── function/
│   └── fetch_exchange_rates.xs # Function implementation
└── README.md                   # This file
```

## Error Handling

The run job handles various error scenarios:

- **Missing API Key**: Returns error if `FIXER_API_KEY` is not set
- **Invalid API Key**: Returns authentication error (401)
- **Rate Limiting**: Returns rate limit error (429)
- **API Errors**: Returns descriptive error messages from Fixer API

## API Limits

Fixer.io has different rate limits based on your subscription plan:
- **Free**: 100 requests/month
- **Basic**: 10,000 requests/month
- **Professional**: 100,000 requests/month
- **Enterprise**: Unlimited

Plan details: https://fixer.io/product

## Use Cases

- E-commerce applications needing real-time currency conversion
- Financial dashboards displaying exchange rates
- Travel apps showing local currency values
- Accounting tools requiring historical rate lookups

## References

- [Fixer.io Documentation](https://fixer.io/documentation)
- [Xano Run Jobs Documentation](https://docs.xano.com/run-jobs)
