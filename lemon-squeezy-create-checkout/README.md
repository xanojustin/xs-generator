# Lemon Squeezy Create Checkout - Xano Run Job

This Xano Run Job creates a checkout session using the Lemon Squeezy API. It demonstrates how to integrate with Lemon Squeezy's payment processing service from Xano for selling digital products and SaaS subscriptions.

## What This Run Job Does

The `Lemon Squeezy Create Checkout` run job processes a purchase by:
1. Accepting customer details (email, name, billing address)
2. Accepting product details (store ID, variant ID)
3. Making an authenticated request to Lemon Squeezy's `/v1/checkouts` endpoint
4. Returning the created checkout object with the checkout URL for the customer to complete payment

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `lemon_squeezy_api_key` | Your Lemon Squeezy API Key | `eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9...` |

### Getting Your Lemon Squeezy API Key

1. Log in to your [Lemon Squeezy Dashboard](https://app.lemonsqueezy.com)
2. Go to Settings → API
3. Click "Create API Key"
4. Copy the generated API key

### Getting Your Store ID and Variant ID

**Store ID:**
1. In your Lemon Squeezy dashboard, go to Settings → Stores
2. Your store ID is in the URL or store settings

**Variant ID:**
1. Go to Products → Select your product
2. The variant ID is found in the variant settings or URL

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Lemon Squeezy Create Checkout"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Lemon Squeezy Create Checkout"
}
```

### Customizing the Checkout

Edit the `input` block in `run.xs`:

```xs
run.job "Lemon Squeezy Create Checkout" {
  main = {
    name: "lemon_squeezy_create_checkout"
    input: {
      store_id: "12345"
      variant_id: "67890"
      email: "customer@example.com"
      name: "Jane Smith"
      billing_address_country: "US"
      billing_address_zip: "90210"
    }
  }
  env = ["lemon_squeezy_api_key"]
}
```

### Dynamic Checkout Creation

To create checkouts dynamically with different parameters, call the function directly from your Xano API endpoints:

```xs
function "create_dynamic_checkout" {
  input {
    text product_variant_id
    text customer_email
    text customer_name
  }
  stack {
    // Call the Lemon Squeezy function
    var $checkout {
      value = function.lemon_squeezy_create_checkout({
        store_id: $env.lemon_squeezy_store_id,
        variant_id: $input.product_variant_id,
        email: $input.customer_email,
        name: $input.customer_name,
        billing_address_country: "US",
        billing_address_zip: "00000"
      })
    }
    
    // Extract the checkout URL
    var $checkout_url {
      value = $checkout.data.attributes.url
    }
  }
  response = {
    checkout_url: $checkout_url,
    checkout_id: $checkout.data.id
  }
}
```

## File Structure

```
lemon-squeezy-create-checkout/
├── run.xs                                          # Run job configuration
├── function/
│   └── lemon_squeezy_create_checkout.xs            # Function that calls Lemon Squeezy API
└── README.md                                       # This file
```

## Response Format

On success, the function returns a Lemon Squeezy Checkout object:

```json
{
  "data": {
    "id": "123456789",
    "type": "checkouts",
    "attributes": {
      "store_id": 12345,
      "variant_id": 67890,
      "checkout_data": {
        "email": "customer@example.com",
        "name": "Jane Smith",
        "billing_address": {
          "country": "US",
          "zip": "90210"
        }
      },
      "product_options": {
        "enabled_variants": [67890],
        "redirect_url": "https://your-app.com/thank-you"
      },
      "url": "https://your-store.lemonsqueezy.com/checkout/custom/abc123...",
      "created_at": "2024-01-15T10:30:00.000000Z",
      "updated_at": "2024-01-15T10:30:00.000000Z"
    },
    "relationships": {
      "store": {
        "data": {
          "type": "stores",
          "id": "12345"
        }
      },
      "variant": {
        "data": {
          "type": "variants",
          "id": "67890"
        }
      }
    }
  }
}
```

## Key Response Fields

| Field | Description |
|-------|-------------|
| `data.id` | The unique checkout ID |
| `data.attributes.url` | The checkout URL to redirect customers to |
| `data.attributes.checkout_data.email` | Customer email |
| `data.attributes.product_options.redirect_url` | Where customer goes after purchase |

## Error Handling

The function throws a `LemonSqueezyAPIError` if:
- The Lemon Squeezy API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API key)
- The store ID or variant ID is invalid

Common error codes:
- `401` - Unauthorized (invalid API key)
- `422` - Validation error (invalid store/variant ID)
- `404` - Resource not found

## Security Notes

- **Never commit your Lemon Squeezy API key** - always use environment variables
- Use separate API keys for development and production
- Implement webhook handling to receive order confirmations
- Validate all customer input before creating checkouts
- Consider using signature verification for webhooks

## Webhook Integration

To handle order confirmations, create a webhook endpoint in Xano:

```xs
query "webhook/lemonsqueezy_post" {
  input {
    json payload { description = "Webhook payload from Lemon Squeezy" }
  }
  stack {
    // Verify webhook signature (recommended)
    // Process order based on event type
    // Common events: order_created, subscription_created, etc.
  }
  response = { received: true }
}
```

## Additional Resources

- [Lemon Squeezy API Documentation](https://docs.lemonsqueezy.com/api)
- [Lemon Squeezy Webhooks](https://docs.lemonsqueezy.com/guides/developer-guide/webhooks)
- [XanoScript Documentation](https://docs.xano.com)
