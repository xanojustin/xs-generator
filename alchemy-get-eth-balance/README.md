# Alchemy Get ETH Balance

A Xano Run Job that fetches Ethereum wallet balances using the Alchemy Web3 API.

## What This Run Job Does

This run job queries the Alchemy API to fetch the ETH balance of any Ethereum wallet address. It:

1. Accepts an Ethereum wallet address as input
2. Validates the address format (0x prefix, 42 characters)
3. Calls Alchemy's JSON-RPC endpoint (`eth_getBalance`)
4. Converts the balance from wei (hex) to ETH (decimal)
5. Logs the query to a local database table
6. Returns the wallet balance with metadata

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `ALCHEMY_API_KEY` | Your Alchemy API key | Sign up at [alchemy.com](https://alchemy.com) and create an app |

## How to Use

### Running the Job

```bash
# Set your Alchemy API key
export ALCHEMY_API_KEY="your-api-key-here"

# Run the job
xano run
```

### Customizing the Wallet Address

Edit `run.xs` and change the `wallet_address` in the input block:

```xs
run.job "Alchemy Get ETH Balance" {
  main = {
    name: "fetch_eth_balance"
    input: {
      wallet_address: "0xYourWalletAddressHere"
    }
  }
  env = ["ALCHEMY_API_KEY"]
}
```

### Using the Function Directly

You can also call the `fetch_eth_balance` function from other Xano code:

```xs
fetch_eth_balance {
  wallet_address = "0x742d35Cc6634C0532925a3b844Bc9e7595f7cB8E"
} as $result

// $result.balance_eth contains the ETH balance
```

## Response Format

```json
{
  "wallet_address": "0x742d35Cc6634C0532925a3b844Bc9e7595f7cB8E",
  "balance_wei": 1234567890000000000,
  "balance_eth": 1.23456789,
  "network": "ethereum-mainnet",
  "timestamp": "2026-02-14T21:45:00Z",
  "query_id": 1
}
```

## Files

| File | Purpose |
|------|---------|
| `run.xs` | Run job configuration |
| `function/fetch_eth_balance.xs` | Main logic for fetching ETH balance |
| `table/wallet_query.xs` | Database table for query logging |

## API Reference

This job uses Alchemy's Ethereum JSON-RPC API:

- **Endpoint**: `https://eth-mainnet.g.alchemy.com/v2/{api_key}`
- **Method**: `eth_getBalance`
- **Documentation**: [Alchemy Docs](https://docs.alchemy.com/reference/eth-getbalance)

## Error Handling

The function handles several error cases:

- Missing or empty wallet address
- Invalid wallet address format
- Alchemy API HTTP errors
- JSON-RPC errors from the Ethereum node

All errors are thrown with descriptive messages.

## Extending This Job

You can extend this job to:

- Fetch token balances (ERC-20) using `alchemy_getTokenBalances`
- Fetch NFTs owned by the wallet using `alchemy_getNFTs`
- Fetch transaction history using `alchemy_getAssetTransfers`
- Monitor multiple wallets in a batch job
