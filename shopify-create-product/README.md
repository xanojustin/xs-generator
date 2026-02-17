# Shopify Create Product - Xano Run Job

This Xano Run Job creates a product in your Shopify store using the Shopify Admin API. It demonstrates how to integrate with Shopify's e-commerce platform from Xano.

## What This Run Job Does

The `Shopify Create Product` run job creates a new product by:
1. Accepting product details (title, description, price, inventory, etc.)
2. Making an authenticated request to Shopify's `/admin/api/2024-01/products.json` endpoint
3. Returning the created product object with details like product ID, variants, and status

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `shopify_store_domain` | Your Shopify store's domain prefix (without `.myshopify.com`) | `my-store` |
| `shopify_access_token` | Your Shopify Admin API access token | `shpat_...` |

### Getting Your Shopify Credentials

1. **Store Domain:**
   - Log in to your [Shopify Admin](https://admin.shopify.com)
   - Your store domain is the prefix before `.myshopify.com` in your admin URL
   - Example: If your admin URL is `my-store.myshopify.com`, your domain is `my-store`

2. **Access Token:**
   - Go to Settings → Apps and sales channels → Develop apps
   - Create a private app or use an existing one
   - Enable the `write_products` scope under Admin API access scopes
   - Generate an access token (starts with `shpat_`)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Shopify Create Product"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Shopify Create Product"
}
```

### Customizing the Product

Edit the `input` block in `run.xs`:

```xs
run.job "Shopify Create Product" {
  main = {
    name: "shopify_create_product"
    input: {
      title: "My Awesome Product"
      body_html: "<p>Product description here</p>"
      vendor: "My Brand"
      product_type: "Clothing"
      tags: ["new", "featured", "sale"]
      price: "49.99"
      sku: "PROD-001"
      inventory_quantity: 50
    }
  }
  env = ["shopify_store_domain", "shopify_access_token"]
}
```

### Input Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `title` | text | Product name displayed in your store |
| `body_html` | text | HTML description of the product |
| `vendor` | text | Brand or manufacturer name |
| `product_type` | text | Category or type of product |
| `tags` | text[] | Array of tags for organizing products |
| `price` | text | Price as a string (e.g., "29.99") |
| `sku` | text | Unique stock keeping unit |
| `inventory_quantity` | int | Initial stock quantity |

## File Structure

```
shopify-create-product/
├── run.xs                              # Run job configuration
├── function/
│   └── shopify_create_product.xs       # Function that calls Shopify API
└── README.md                           # This file
```

## Response Format

On success, the function returns a Shopify Product object:

```json
{
  "product": {
    "id": 123456789,
    "title": "Xano Test Product",
    "body_html": "<p>This is a test product created via Xano Run Job</p>",
    "vendor": "Xano Store",
    "product_type": "Test Product",
    "created_at": "2024-01-15T10:30:00-05:00",
    "handle": "xano-test-product",
    "updated_at": "2024-01-15T10:30:00-05:00",
    "published_at": "2024-01-15T10:30:00-05:00",
    "template_suffix": null,
    "published_scope": "global",
    "tags": "xano, test, api",
    "variants": [
      {
        "id": 987654321,
        "product_id": 123456789,
        "title": "Default Title",
        "price": "29.99",
        "sku": "XANO-TEST-001",
        "position": 1,
        "inventory_policy": "deny",
        "compare_at_price": null,
        "fulfillment_service": "manual",
        "inventory_management": null,
        "option1": "Default Title",
        "option2": null,
        "option3": null,
        "created_at": "2024-01-15T10:30:00-05:00",
        "updated_at": "2024-01-15T10:30:00-05:00",
        "taxable": true,
        "barcode": null,
        "grams": 0,
        "image_id": null,
        "weight": 0,
        "weight_unit": "kg",
        "inventory_item_id": 111222333,
        "inventory_quantity": 100,
        "old_inventory_quantity": 100,
        "requires_shipping": true,
        "admin_graphql_api_id": "gid://shopify/ProductVariant/987654321"
      }
    ],
    "options": [
      {
        "id": 444555666,
        "product_id": 123456789,
        "name": "Title",
        "position": 1,
        "values": ["Default Title"]
      }
    ],
    "images": [],
    "image": null
  }
}
```

## Error Handling

The function throws a `ShopifyAPIError` if:
- The Shopify API returns a non-2xx status code
- The request times out
- Authentication fails (invalid access token or store domain)
- Required fields are missing or invalid
- Rate limits are exceeded (Shopify has API rate limits)

## Common Shopify API Errors

| Status | Error | Solution |
|--------|-------|----------|
| 401 | Unauthorized | Check your access token and store domain |
| 403 | Forbidden | Ensure your app has `write_products` permission |
| 422 | Unprocessable Entity | Check your input data for validation errors |
| 429 | Too Many Requests | You've hit Shopify's rate limit; wait before retrying |
| 500+ | Server Error | Shopify's servers are having issues; retry later |

## Shopify API Rate Limits

Shopify uses a leaky bucket algorithm for rate limiting:
- **REST Admin API:** 40 requests per second per app per store
- **GraphQL Admin API:** 100 points per second per app per store

The function includes a 30-second timeout to handle slow responses.

## Security Notes

- **Never commit your Shopify access token** - always use environment variables
- Use a dedicated private app with minimal required permissions
- Rotate your access tokens periodically
- Monitor your API usage in the Shopify Partner dashboard
- Consider implementing retry logic with exponential backoff for rate limiting

## Additional Resources

- [Shopify Admin API Documentation](https://shopify.dev/docs/api/admin-rest)
- [Shopify Product API Reference](https://shopify.dev/docs/api/admin-rest/2024-01/resources/product)
- [Shopify API Rate Limits](https://shopify.dev/docs/api/usage/rate-limits)
- [XanoScript Documentation](https://docs.xano.com)
