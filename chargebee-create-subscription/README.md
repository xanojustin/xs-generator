# Chargebee Create Subscription Run Job

This XanoScript run job creates a subscription in Chargebee, optionally creating a new customer at the same time.

## What It Does

This run job creates a Chargebee subscription with the following capabilities:

- Creates a subscription for a specified plan
- Creates a new customer (or uses an existing customer ID)
- Supports billing address collection
- Configurable trial period
- Coupon code application
- Purchase order number support
- Returns subscription ID, status, and customer details

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `CHARGEBEE_API_KEY` | Your Chargebee API key (found in Settings > API Keys) |
| `CHARGEBEE_SITE_NAME` | Your Chargebee site name (the subdomain, e.g., `your-company` from `your-company.chargebee.com`) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `plan_id` | text | Yes | Chargebee plan ID (e.g., `basic-plan`, `pro-monthly`) |
| `customer_email` | text | Yes | Customer email address |
| `customer_id` | text | No | Existing Chargebee customer ID (skip to create new customer) |
| `customer_first_name` | text | No | Customer first name (for new customer) |
| `customer_last_name` | text | No | Customer last name (for new customer) |
| `billing_address_line1` | text | No | Billing address line 1 |
| `billing_address_city` | text | No | Billing city |
| `billing_address_state` | text | No | Billing state/province |
| `billing_address_zip` | text | No | Billing ZIP/postal code |
| `billing_address_country` | text | No | Billing country code (e.g., `US`, `CA`, `GB`) |
| `trial_days` | integer | No | Number of trial days (uses plan default if not set) |
| `coupon_ids` | text | No | Comma-separated coupon IDs to apply |
| `po_number` | text | No | Purchase order number for invoicing |

### Response

```json
{
  "success": true,
  "subscription_id": "subscription_1234567890",
  "customer_id": "customer_1234567890",
  "status": "in_trial",
  "subscription_data": {
    "id": "subscription_1234567890",
    "plan_id": "basic-plan",
    "plan_quantity": 1,
    "status": "in_trial",
    "trial_start": 1708123456,
    "trial_end": 1709333056,
    "current_term_start": 1709333056,
    "current_term_end": 1712011456
  },
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "subscription_id": null,
  "customer_id": null,
  "status": null,
  "subscription_data": null,
  "error": "Plan with id 'invalid-plan' does not exist."
}
```

## File Structure

```
chargebee-create-subscription/
├── run.xs                           # Run job definition
├── function/
│   └── create_subscription.xs       # Function to create subscription
├── README.md                        # This file
└── FEEDBACK.md                      # MCP/XanoScript feedback
```

## Chargebee API Reference

- [Create Subscription API](https://apidocs.chargebee.com/docs/api/subscriptions#create_a_subscription)
- [Plans API](https://apidocs.chargebee.com/docs/api/plans)
- [Customers API](https://apidocs.chargebee.com/docs/api/customers)
- [Test Mode](https://www.chargebee.com/docs/2.0/testing.html)

## Testing

Use Chargebee's test mode environment for testing:
1. Log into your Chargebee dashboard
2. Switch to Test Mode
3. Create test plans
4. Use the test site name and API key

## Common Plan Statuses

- `in_trial` - Subscription is in trial period
- `active` - Subscription is active and billing
- `future` - Subscription will start in the future
- `cancelled` - Subscription has been cancelled
- `non_renewing` - Subscription won't renew at end of term

## Security Notes

- Never commit your `CHARGEBEE_API_KEY` to version control
- Use Chargebee's test mode keys during development
- Store API keys in environment variables only
- The API key should have restricted permissions if possible
