# Binance Get Crypto Price Run Job

This XanoScript run job fetches the current price of a cryptocurrency from the Binance API.

## What It Does

This run job retrieves the current market price for a cryptocurrency trading pair from Binance's public API. It handles:

- Fetching real-time price data for any supported trading pair
- Returning the current price, 24h change, volume, and other market data
- Error handling for invalid trading pairs or API issues

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `BINANCE_API_KEY` | Your Binance API key (optional for public endpoints, required for higher rate limits) |

**Note:** This run job uses Binance's public API endpoint which does not require authentication for basic price queries. However, providing an API key increases rate limits.

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `symbol` | text | Yes | Trading pair symbol (e.g., `BTCUSDT`, `ETHUSDT`, `SOLUSDT`) |

### Response

```json
{
  "success": true,
  "symbol": "BTCUSDT",
  "price": "65432.50",
  "price_change_24h": "1234.56",
  "price_change_percent_24h": "1.92",
  "volume_24h": "15234.56789012",
  "quote_volume_24h": "996789012.34567890",
  "high_price_24h": "66123.45",
  "low_price_24h": "64123.45",
  "last_update_time": "1708101234567",
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "symbol": "INVALID",
  "price": null,
  "price_change_24h": null,
  "price_change_percent_24h": null,
  "volume_24h": null,
  "quote_volume_24h": null,
  "high_price_24h": null,
  "low_price_24h": null,
  "last_update_time": null,
  "error": "Invalid symbol."
}
```

## File Structure

```
binance-get-crypto-price/
├── run.xs                    # Run job definition
├── function/
│   └── get_crypto_price.xs   # Function to fetch crypto price
└── README.md                 # This file
```

## Binance API Reference

- [Binance API Documentation](https://binance-docs.github.io/apidocs/spot/en/)
- [Ticker Price 24hr Endpoint](https://binance-docs.github.io/apidocs/spot/en/#24hr-ticker-price-change-statistics)
- [Exchange Info (for valid symbols)](https://binance-docs.github.io/apidocs/spot/en/#exchange-information)

## Popular Trading Pairs

- `BTCUSDT` - Bitcoin to USDT
- `ETHUSDT` - Ethereum to USDT
- `SOLUSDT` - Solana to USDT
- `ADAUSDT` - Cardano to USDT
- `DOTUSDT` - Polkadot to USDT
- `BNBUSDT` - Binance Coin to USDT
- `XRPUSDT` - Ripple to USDT

## Rate Limits

- Public endpoints: 1200 request weight per minute (IP-based)
- With API key: Higher limits and user-based tracking

## Security Notes

- Never commit your `BINANCE_API_KEY` to version control
- Use IP whitelist restrictions if possible
- The API key only needs read permissions for this endpoint
