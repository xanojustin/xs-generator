# CoinGecko Get Crypto Price

A Xano Run Job that fetches current cryptocurrency prices from the CoinGecko API.

## What This Run Job Does

This run job fetches real-time cryptocurrency prices from CoinGecko's free public API. It supports multiple cryptocurrencies and multiple target currencies in a single request.

## Features

- Fetch prices for multiple cryptocurrencies (Bitcoin, Ethereum, etc.)
- Get prices in multiple fiat currencies (USD, EUR, GBP, etc.)
- Uses CoinGecko's free tier (no API key required for basic usage)
- Clean, well-structured XanoScript code

## Required Environment Variables

None! CoinGecko's basic API is free and doesn't require an API key. However, for production use with higher rate limits, you may want to set:

- `COINGECKO_API_KEY` - (Optional) Your CoinGecko API key for higher rate limits

## How to Use

### Default Behavior

The run job fetches Bitcoin and Ethereum prices in USD by default.

### Customizing Input Parameters

Edit the `input` block in `run.xs`:

```xs
run.job "Fetch Crypto Price" {
  main = {
    name: "fetch_crypto_price"
    input: {
      coin_ids: "bitcoin,ethereum,cardano,solana"
      vs_currencies: "usd,eur,gbp"
    }
  }
}
```

### Available Coin IDs

Popular coin IDs include:
- `bitcoin`
- `ethereum`
- `cardano`
- `solana`
- `polkadot`
- `ripple` (XRP)
- `dogecoin`

Find more at: https://www.coingecko.com/en/coins/all

### Available Currencies

Popular currencies include:
- `usd` - US Dollar
- `eur` - Euro
- `gbp` - British Pound
- `jpy` - Japanese Yen
- `cad` - Canadian Dollar
- `aud` - Australian Dollar

## API Response Format

```json
{
  "bitcoin": {
    "usd": 43250.50,
    "eur": 39820.25
  },
  "ethereum": {
    "usd": 2280.75,
    "eur": 2098.40
  }
}
```

## File Structure

```
coingecko-get-crypto-price/
├── run.xs                      # Run job configuration
├── function/
│   └── fetch_crypto_price.xs   # Function that calls CoinGecko API
└── README.md                   # This file
```

## CoinGecko API Documentation

- Main API Docs: https://www.coingecko.com/en/api
- Free tier: 10-30 calls/minute
- Paid tier: Higher rate limits available

## Notes

- CoinGecko's free tier has rate limits. If you hit limits, consider adding delays between requests or upgrading to a paid plan.
- The API returns prices in real-time from various exchanges.
