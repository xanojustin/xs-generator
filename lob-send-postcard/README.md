# Lob Send Postcard

This Xano Run Job sends physical postcards using the [Lob API](https://lob.com/). Lob is a print and mail API that enables developers to programmatically send physical mail including postcards, letters, and checks.

## What This Run Job Does

The run job calls a function that:
1. Validates all required address fields
2. Constructs a postcard payload with recipient information
3. Sends a POST request to Lob's `/v1/postcards` endpoint
4. Returns the postcard details including tracking ID and expected delivery date

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `LOB_API_KEY` | Your Lob API key | Sign up at [lob.com](https://lob.com/) and get your API key from the dashboard. Use your **Live API Key** for production or **Test API Key** for testing. |

## Input Parameters

### Required

| Parameter | Type | Description |
|-----------|------|-------------|
| `to_name` | text | Recipient's full name |
| `to_address_line1` | text | Street address (e.g., "123 Main Street") |
| `to_city` | text | City name |
| `to_state` | text | Two-letter state code (e.g., "CA") |
| `to_zip` | text | ZIP code (5 digits or ZIP+4 format) |
| `front_image_url` | text | Publicly accessible URL to the postcard front image (PNG, JPG, or PDF). Must be at least 1875x1275 pixels. |
| `back_message` | text | Message to print on the back of the postcard. Can include HTML formatting. |

### Optional

| Parameter | Type | Description |
|-----------|------|-------------|
| `to_address_line2` | text | Apartment, suite, or unit number |

## Response

On success, returns an object with:

```json
{
  "success": true,
  "postcard_id": "psc_1234567890abcdef",
  "expected_delivery_date": "2025-02-25",
  "url": "https://lob.com/postcards/psc_1234567890abcdef",
  "to": {
    "name": "John Doe",
    "address_line1": "123 Main Street",
    "address_city": "San Francisco",
    "address_state": "CA",
    "address_zip": "94102"
  },
  "status": "processed"
}
```

## Usage

### Default Input (in run.xs)

The run job includes default input values that you can modify:

```xs
run.job "Send Lob Postcard" {
  main = {
    name: "send_postcard"
    input: {
      to_name: "John Doe"
      to_address_line1: "123 Main Street"
      to_city: "San Francisco"
      to_state: "CA"
      to_zip: "94102"
      front_image_url: "https://example.com/postcard-front.jpg"
      back_message: "Hello from Xano! This postcard was sent via the Lob API using XanoScript."
    }
  }
  env = ["LOB_API_KEY"]
}
```

### Running the Job

Use the Xano CLI or Meta API to execute this run job:

```bash
# Via Xano CLI
xano run execute --job "Send Lob Postcard"

# Or via the Run API
POST https://app.dev.xano.com/api:run/v1/job/run
{
  "job_name": "Send Lob Postcard",
  "input": {
    "to_name": "Jane Smith",
    "to_address_line1": "456 Oak Avenue",
    "to_city": "New York",
    "to_state": "NY",
    "to_zip": "10001",
    "front_image_url": "https://mycdn.com/postcard.jpg",
    "back_message": "Greetings from NYC!"
  }
}
```

## Error Handling

The function handles common errors:

- **Input Validation (400)**: Missing required fields
- **Authentication (401)**: Invalid API key
- **Validation (422)**: Invalid address, image URL, or other Lob validation errors
- **Other Errors**: Generic API errors with status code details

## Testing

Lob provides a test mode where postcards are not actually printed or mailed. Use your **Test API Key** to test without incurring charges. Test mode postcards will still return a valid response with a postcard ID.

## File Structure

```
lob-send-postcard/
├── run.xs              # Run job configuration
├── function/
│   └── send_postcard.xs  # Function that sends the postcard
└── README.md           # This file
```

## Resources

- [Lob Documentation](https://docs.lob.com/)
- [Lob Postcard API Reference](https://docs.lob.com/#tag/Postcards)
- [Lob Test vs Live Environment](https://docs.lob.com/#section/Test-and-Live-Environments)
