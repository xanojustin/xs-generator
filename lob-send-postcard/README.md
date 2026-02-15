# Lob Send Postcard - Xano Run Job

This Xano Run Job sends physical postcards via the [Lob API](https://lob.com/). Lob is a direct mail API that enables programmatic sending of postcards, letters, and checks.

## What This Run Job Does

This run job demonstrates how to send a physical postcard through the mail using Lob's API. It includes:

- Configurable sender and recipient addresses
- HTML-based postcard design (front and back)
- Multiple postcard sizes (4x6, 6x9, 6x11)
- Test mode support for safe development
- Full error handling and validation

## Required Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `LOB_TEST_API_KEY` | Yes (for test mode) | Your Lob test API key (starts with `test_`) |
| `LOB_LIVE_API_KEY` | Yes (for live mode) | Your Lob live API key (starts with `live_`) |

### Getting API Keys

1. Sign up at [Lob.com](https://lob.com/)
2. Navigate to Settings → API Keys
3. Copy your test and live API keys
4. Set them as environment variables in your Xano workspace

## How to Use

### Basic Usage

The run job is configured in `run.xs` with example data. Modify the input parameters to send your own postcard:

```xs
run.job "Send Lob Postcard" {
  main = {
    name: "send_postcard"
    input: {
      to_name: "Recipient Name"
      to_address_line1: "123 Main St"
      to_city: "San Francisco"
      to_state: "CA"
      to_zip: "94105"
      from_name: "Your Name"
      from_address_line1: "456 Market St"
      from_city: "San Francisco"
      from_state: "CA"
      from_zip: "94103"
      front_html: "<html><body>Your HTML design here</body></html>"
      back_html: "<html><body>Your message here</body></html>"
      size: "4x6"
      use_test_mode: true
    }
  }
}
```

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `to_name` | string | Yes | - | Recipient's full name |
| `to_address_line1` | string | Yes | - | Recipient's street address |
| `to_address_line2` | string | No | - | Apartment, suite, etc. |
| `to_city` | string | Yes | - | Recipient's city |
| `to_state` | string | Yes | - | Recipient's state (2-letter code) |
| `to_zip` | string | Yes | - | Recipient's ZIP code |
| `to_country` | string | No | "US" | Recipient's country (ISO 3166-1 alpha-2) |
| `from_name` | string | Yes | - | Sender's full name |
| `from_address_line1` | string | Yes | - | Sender's street address |
| `from_address_line2` | string | No | - | Apartment, suite, etc. |
| `from_city` | string | Yes | - | Sender's city |
| `from_state` | string | Yes | - | Sender's state |
| `from_zip` | string | Yes | - | Sender's ZIP code |
| `from_country` | string | No | "US" | Sender's country |
| `front_html` | string | Yes | - | HTML content for postcard front |
| `back_html` | string | Yes | - | HTML content for postcard back |
| `size` | string | No | "4x6" | Postcard size: "4x6", "6x9", or "6x11" |
| `use_test_mode` | boolean | No | true | Use test API (true) or live API (false) |

### HTML Design Guidelines

Lob requires specific dimensions for postcard HTML:

- **4x6 postcards**: 6.25in × 4.25in (includes bleed)
- **6x9 postcards**: 9.25in × 6.25in
- **6x11 postcards**: 11.25in × 6.25in

Example front HTML template:
```html
<html>
  <body style="margin:0;padding:0;">
    <div style="width:6.25in;height:4.25in;background:#f0f0f0;display:flex;align-items:center;justify-content:center;">
      <h1>Your Design Here</h1>
    </div>
  </body>
</html>
```

### Test Mode vs Live Mode

- **Test Mode** (`use_test_mode: true`): Uses `LOB_TEST_API_KEY`. Postcards are not actually mailed. Use for development and testing.
- **Live Mode** (`use_test_mode: false`): Uses `LOB_LIVE_API_KEY`. Real postcards are printed and mailed. Costs real money!

## Response Format

### Success Response

```json
{
  "success": true,
  "postcard_id": "psc_1234567890abcdef",
  "url": "https://lob.com/postcards/psc_1234567890abcdef",
  "expected_delivery_date": "2024-03-20",
  "to": { ... },
  "from": { ... },
  "thumbnails": [ ... ],
  "mode": "test"
}
```

### Error Response

```json
{
  "success": false,
  "error": "Validation failed",
  "details": { ... },
  "status_code": 422
}
```

## File Structure

```
lob-send-postcard/
├── run.xs                    # Run job configuration
├── function/
│   └── send_postcard.xs      # Main function
└── README.md                 # This file
```

## Additional Resources

- [Lob API Documentation](https://docs.lob.com/)
- [Lob Postcard Guide](https://docs.lob.com/#tag/Postcards)
- [Lob HTML Templates](https://docs.lob.com/#section/HTML-Templates)
- [XanoScript Documentation](https://docs.xano.com/xanoscript)

## Notes

- The sender address must be a valid US address in live mode
- International addresses may have additional requirements
- Lob charges per postcard sent in live mode
- Test API calls are free but don't produce physical mail
