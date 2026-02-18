# IPinfo Geolocation Run Job

A Xano Run Job that looks up geolocation data for IP addresses using the [IPinfo](https://ipinfo.io) API.

## What This Run Job Does

This run job calls the IPinfo API to retrieve geolocation information for a given IP address. If no IP is provided, it returns data for the current request's IP address.

### Features

- Look up any IPv4 or IPv6 address
- Returns city, region, country, coordinates, ISP info, postal code, and timezone
- Returns current IP info when no IP specified
- Includes privacy/VPN detection data when available

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `IPINFO_API_KEY` | Your IPinfo API token | Yes |

Get a free API key at: https://ipinfo.io/signup

## How to Use

### Run the Job

```bash
# With specific IP
xano run --job=ipinfo-geolocation --input='{"ip": "8.8.8.8"}'

# Without IP (uses current IP)
xano run --job=ipinfo-geolocation --input='{}'
```

### Response Format

```json
{
  "ip": "8.8.8.8",
  "city": "Mountain View",
  "region": "California",
  "country": "US",
  "loc": "37.3860,-122.0838",
  "org": "AS15169 Google Inc.",
  "postal": "94035",
  "timezone": "America/Los_Angeles",
  "hostname": "dns.google",
  "privacy": null
}
```

## File Structure

```
ipinfo-geolocation/
├── run.xs                    # Run job configuration
├── function/
│   └── lookup_ip.xs         # IP lookup function
└── README.md                # This file
```

## API Reference

See [IPinfo API Documentation](https://ipinfo.io/developers) for more details on available data fields and endpoints.

## Error Handling

The run job will throw an error if:
- `IPINFO_API_KEY` is not set
- The IPinfo API returns a non-200 status code
- The IP address format is invalid

## Rate Limits

Free tier: 50,000 requests per month
Paid tiers: Higher limits available

See https://ipinfo.io/pricing for details.
