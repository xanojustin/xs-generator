# EasyPost Create Shipment Run Job

This XanoScript run job creates a shipping label using the EasyPost API. EasyPost provides a unified API for shipping with multiple carriers including USPS, UPS, FedEx, DHL, and more.

## What It Does

This run job creates a shipment and retrieves available shipping rates. It handles:

- Creating a shipment with to/from addresses and parcel details
- Validating address information
- Retrieving shipping rates from multiple carriers
- Returning tracking information and label URLs
- Supporting both address objects and existing EasyPost address IDs

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `EASYPOST_API_KEY` | Your EasyPost API key (starts with `EZ...` for test, or production key) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

**Recipient Address (To):**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `to_address_name` | text | Yes | Recipient full name |
| `to_address_street1` | text | Yes | Street address line 1 |
| `to_address_street2` | text | No | Street address line 2 (apartment, suite, etc.) |
| `to_address_city` | text | Yes | City |
| `to_address_state` | text | Yes | State/province (2-letter code, e.g., "CA") |
| `to_address_zip` | text | Yes | ZIP or postal code |
| `to_address_country` | text | No | Country code (default: "US") |
| `to_address_phone` | text | No | Phone number |

**Sender Address (From) - Option 1: Use existing EasyPost Address ID:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `from_address_id` | text | Yes* | EasyPost Address ID (e.g., "addr_1234567890") |

**Sender Address (From) - Option 2: Provide full address:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `from_address_name` | text | Yes* | Sender full name |
| `from_address_street1` | text | Yes* | Street address line 1 |
| `from_address_city` | text | Yes* | City |
| `from_address_state` | text | Yes* | State (2-letter code) |
| `from_address_zip` | text | Yes* | ZIP code |

*Only required if not using `from_address_id`

**Parcel Details:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `parcel_weight` | text | Yes | Weight in ounces (e.g., "16" for 1 lb) |
| `parcel_length` | text | No | Length in inches |
| `parcel_width` | text | No | Width in inches |
| `parcel_height` | text | No | Height in inches |

**Optional Preferences:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `carrier` | text | No | Preferred carrier (e.g., "USPS", "UPS", "FedEx") |
| `service` | text | No | Service level (e.g., "Priority", "Ground") |

### Response

```json
{
  "success": true,
  "shipment_id": "shp_1234567890abcdef",
  "tracking_code": "9400111899223456789012",
  "tracking_url": "https://track.easypost.com/dj...",
  "label_url": "https://amazonaws.com/label.pdf",
  "rate_id": "rate_abcdef1234567890",
  "carrier": "USPS",
  "service": "Priority",
  "shipping_cost": "7.85",
  "rates_available": [...],
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "shipment_id": null,
  "tracking_code": null,
  "tracking_url": null,
  "label_url": null,
  "rate_id": null,
  "carrier": null,
  "service": null,
  "shipping_cost": null,
  "rates_available": [],
  "error": "Address verification failed: Invalid ZIP code"
}
```

## File Structure

```
easypost-create-shipment/
├── run.xs                      # Run job definition
├── function/
│   └── create_shipment.xs      # Function to create shipment
├── README.md                   # This file
└── FEEDBACK.md                 # Development feedback
```

## EasyPost API Reference

- [Shipments API](https://www.easypost.com/docs/api/shipments)
- [Address Verification](https://www.easypost.com/docs/api/addresses#verify-address)
- [Carriers](https://www.easypost.com/docs/api/carriers)

## Testing

EasyPost provides a test environment. Use test API keys (starting with `EZ...`) for development:
- Test keys won't create real shipments or charge your account
- Test shipments return mock rates and labels
- Use "USPS" for most reliable test results

## Buying Shipping Labels

This run job creates a shipment and retrieves rates. To actually purchase a shipping label:
1. Call this job to get available rates
2. Select a rate (use the `rate_id` from the response)
3. Make a separate API call to EasyPost to buy the shipment:
   ```
   POST /v2/shipments/{shipment_id}/buy
   { "rate": { "id": "rate_xxx" } }
   ```

## Security Notes

- Never commit your `EASYPOST_API_KEY` to version control
- Use EasyPost test keys during development
- Consider using carrier-specific API keys for production
- Store sensitive address data according to your privacy policy
