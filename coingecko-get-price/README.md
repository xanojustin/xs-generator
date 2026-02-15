# CoinGecko Get Crypto Price

A Xano Run Job that fetches current cryptocurrency prices and market data from the CoinGecko API.

## What This Run Job Does

This run job retrieves real-time cryptocurrency price data including:
- Current price in the specified currency
- Market capitalization
- 24-hour trading volume
- 24-hour price change percentage

## Required Environment Variables

None! CoinGecko's public API does not require an API key for basic usage.

## How to Use

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `coin_id` | text | Yes | "bitcoin" | CoinGecko coin ID (e.g., bitcoin, ethereum, cardano) |
| `currency` | text | Yes | "usd" | Target currency code (e.g., usd, eur, gbp) |

### Example Usage

```xs
run.job "Get Bitcoin Price" {
  main = {
    name: "get_crypto_price"
    input: {
      coin_id: "bitcoin"
      currency: "usd"
    }
  }
}
```

### Supported Coin IDs

Common CoinGecko coin IDs include:
- `bitcoin` - Bitcoin (BTC)
- `ethereum` - Ethereum (ETH)
- `cardano` - Cardano (ADA)
- `solana` - Solana (SOL)
- `ripple` - XRP
- `polkadot` - Polkadot (DOT)
- `chainlink` - Chainlink (LINK)

Find more at: https://www.coingecko.com/en/coins/all

### Response Format

```json
{
  "coin_id": "bitcoin",
  "currency": "usd",
  "price": 43250.67,
  "market_cap": 847293456789,
  "volume_24h": 23456789012,
  "change_24h_percent": 2.45,
  "fetched_at": "2026-02-14 19:45:00"
}
```

## API Documentation

- CoinGecko API Docs: https://www.coingecko.com/en/api

## Notes

- CoinGecko has rate limits on the free tier (10-50 calls/minute)
- For production use with high volume, consider upgrading to CoinGecko Pro
