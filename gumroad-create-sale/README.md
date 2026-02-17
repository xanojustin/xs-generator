# Gumroad Create Sale Run Job

This Xano Run Job creates a sale on Gumroad for a digital product. Useful for creators who want to programmatically generate sales, offer free copies to customers, or integrate Gumroad with other systems.

## What It Does

Creates a sale record on Gumroad for a specified product and customer email. This can be used to:
- Give free copies of products to customers
- Create sales from external payment systems
- Automate product delivery workflows
- Generate discount/promo sales

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `gumroad_access_token` | Your Gumroad OAuth access token | Go to Gumroad Settings → Advanced → Generate Access Token |

## How to Use

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `product_id` | text | Yes | Gumroad product ID (permalink) |
| `email` | email | Yes | Customer email address |
| `price` | int | No | Price in cents (optional, uses product default if not provided) |
| `offer_code` | text | No | Offer code to apply (optional) |

### Example Usage

```xs
run.job "Gumroad Create Sale" {
  main = {
    name: "gumroad_create_sale"
    input: {
      product_id: "my-awesome-ebook"
      email: "customer@example.com"
      price: 1000  // $10.00
      offer_code: "WELCOME20"
    }
  }
  env = ["gumroad_access_token"]
}
```

### Finding Your Product ID

1. Go to your Gumroad Products page
2. Click on any product
3. The product ID is the last part of the URL (e.g., `gumroad.com/l/my-awesome-ebook` → product ID is `my-awesome-ebook`)

## API Reference

This run job uses the [Gumroad API](https://app.gumroad.com/api) v2 endpoint:
- `POST /v2/sales` - Create a new sale

## Error Handling

The function handles common error cases:
- **401 Unauthorized** - Invalid access token
- **404 Not Found** - Product doesn't exist
- **API Error** - Other API failures with full error details

## File Structure

```
gumroad-create-sale/
├── run.xs                          # Job configuration
├── function/
│   └── gumroad_create_sale.xs     # Function implementation
└── README.md                       # This file
```

## Security Notes

- Never commit your `gumroad_access_token` to version control
- Use environment variables for all sensitive credentials
- The token grants access to your Gumroad account - keep it secure

## License

MIT
