# ShipStation Create Shipping Label

A Xano Run Job that creates shipping labels via the ShipStation API.

## What This Run Job Does

This run job integrates with ShipStation's shipping API to create shipping labels for e-commerce orders. It supports:

- Creating USPS, UPS, FedEx, and other carrier labels
- Specifying package dimensions and weight
- Calculating shipping costs
- Generating tracking numbers
- Supporting domestic and international shipments

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `shipstation_api_key` | Your ShipStation API Key | `abc123xyz789` |
| `shipstation_api_secret` | Your ShipStation API Secret | `secret456def` |
| `shipstation_base_url` | ShipStation API base URL | `https://ssapi.shipstation.com` |

### Getting ShipStation Credentials

1. Sign up for a ShipStation account at https://www.shipstation.com
2. Go to Settings → API Settings
3. Generate API Keys (API Key and API Secret)
4. Store these securely in your Xano environment variables

## How to Use

### Basic Usage

The run job is configured with default test values in `run.xs`:

```xs
run.job "ShipStation Create Shipping Label" {
  main = {
    name: "create_shipping_label"
    input: {
      order_id: "ORD-12345"
      service_code: "usps_priority"
      package_code: "package"
      weight_oz: 16
      dimensions: {
        length: 10
        width: 6
        height: 4
      }
    }
  }
}
```

### Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `order_id` | text | Yes | Your internal order identifier |
| `service_code` | text | Yes | Carrier service code (e.g., `usps_priority`, `ups_ground`, `fedex_2day`) |
| `package_code` | text | Yes | Package type (e.g., `package`, `flat_rate_envelope`) |
| `weight_oz` | int | Yes | Package weight in ounces |
| `dimensions` | object | Yes | Package dimensions |
| `dimensions.length` | int | Yes | Length in inches |
| `dimensions.width` | int | Yes | Width in inches |
| `dimensions.height` | int | Yes | Height in inches |
| `ship_to_name` | text | No | Recipient name |
| `ship_to_street` | text | No | Street address |
| `ship_to_city` | text | No | City |
| `ship_to_state` | text | No | State/Province code |
| `ship_to_postal_code` | text | No | ZIP/Postal code |
| `ship_to_country` | text | No | Country code (default: `US`) |

### Common Service Codes

| Carrier | Service Code |
|---------|-------------|
| USPS Priority Mail | `usps_priority` |
| USPS First Class | `usps_first_class_mail` |
| USPS Priority Mail Express | `usps_priority_mail_express` |
| UPS Ground | `ups_ground` |
| UPS 2nd Day Air | `ups_2nd_day_air` |
| UPS Next Day Air | `ups_next_day_air` |
| FedEx Ground | `fedex_ground` |
| FedEx 2Day | `fedex_2day` |
| FedEx Standard Overnight | `fedex_standard_overnight` |

## Response

On success, the run job returns:

```json
{
  "success": true,
  "shipment_id": 123456789,
  "tracking_number": "9400111899223456789012",
  "label_data": "base64-encoded-pdf-data...",
  "shipment_cost": 8.50,
  "insurance_cost": 0.00,
  "package_code": "package",
  "service_code": "usps_priority",
  "ship_date": "2024-01-15",
  "created_at": "2024-01-15T10:30:00Z"
}
```

## Files

- `run.xs` - Run job configuration
- `function/create_shipping_label.xs` - Main function implementation

## Error Handling

The function handles common error cases:
- `ValidationError` - Invalid input parameters (400)
- `AuthenticationError` - Invalid API credentials (401)
- `APIError` - Other ShipStation API errors

## Notes

- The label_data field contains base64-encoded PDF data that can be decoded and printed
- Rate limiting applies based on your ShipStation plan
- International shipments require additional customs information
