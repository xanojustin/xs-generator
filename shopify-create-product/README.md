# Shopify Create Product Run Job

This XanoScript run job creates a new product in a Shopify store using the Shopify Admin API.

## What It Does

This run job creates a Shopify product with the following features:

- Creates a product with title, type, vendor, and description
- Sets up a product variant with price and inventory tracking
- Manages inventory quantities with Shopify's inventory management
- Supports product tags for organization
- Handles published/unpublished states
- Returns the created product ID and handle

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SHOPIFY_SHOP_DOMAIN` | Your Shopify shop domain (e.g., `your-store` - without `.myshopify.com`) |
| `SHOPIFY_ACCESS_TOKEN` | Your Shopify Admin API access token |

## Getting Your Credentials

1. **Shop Domain**: This is the subdomain of your Shopify store (e.g., if your store URL is `my-store.myshopify.com`, your shop domain is `my-store`)

2. **Access Token**: 
   - Go to your Shopify Admin → Settings → Apps and sales channels
   - Click "Develop apps" → "Create an app"
   - Configure Admin API scopes (required: `write_products`, `read_products`)
   - Install the app in your store
   - Copy the Admin API access token

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `title` | text | Yes | Product title/name |
| `price` | text | Yes | Product price as a string (e.g., `"29.99"`) |
| `product_type` | text | No | Product category/type (default: `""`) |
| `vendor` | text | No | Product vendor/brand name (default: `""`) |
| `inventory_quantity` | integer | No | Initial stock quantity (default: `0`) |
| `tags` | text | No | Comma-separated tags (e.g., `"electronics, sale, new"`) |
| `description_html` | text | No | Product description in HTML format |
| `published` | boolean | No | Whether to publish immediately (default: `true`) |

### Response

```json
{
  "success": true,
  "product_id": "7234567890123",
  "handle": "new-product-from-xano",
  "product": {
    "id": 7234567890123,
    "title": "New Product from Xano",
    "handle": "new-product-from-xano",
    "product_type": "Electronics",
    "vendor": "Xano Store",
    ...
  },
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "product_id": null,
  "handle": null,
  "product": null,
  "error": "Shopify API error: HTTP 422 - Validation failed"
}
```

## File Structure

```
shopify-create-product/
├── run.xs                    # Run job definition
├── function/
│   └── create_product.xs     # Function to create Shopify product
└── README.md                 # This file
```

## Shopify API Reference

- [Product API Documentation](https://shopify.dev/docs/api/admin-rest/2024-01/resources/product)
- [Authentication Guide](https://shopify.dev/docs/apps/auth/admin-app-access-tokens)
- [Rate Limits](https://shopify.dev/docs/api/usage/rate-limits)

## Testing

Test with sample product data:
- Title: `"Test Product"`
- Price: `"19.99"`
- Product Type: `"Electronics"`
- Vendor: `"Test Vendor"`
- Inventory: `10`
- Tags: `"test, api, xano"`

## Security Notes

- Never commit your `SHOPIFY_ACCESS_TOKEN` to version control
- Use a custom app with minimal required permissions
- The access token grants full access to your store - protect it carefully
- Consider using Shopify's API versioning to ensure compatibility

## Common Issues

| Issue | Solution |
|-------|----------|
| `HTTP 401` | Check your access token is valid and has not expired |
| `HTTP 403` | Ensure your app has `write_products` scope permission |
| `HTTP 422` | Check your product data meets Shopify's validation requirements |
| `HTTP 404` | Verify your shop domain is correct |
