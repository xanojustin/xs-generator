# IPAPI Geolocation Lookup Run Job

This XanoScript run job looks up geolocation data for an IP address using the [ipapi.co](https://ipapi.co) API.

## What It Does

This run job retrieves detailed geolocation information for any IP address, including:

- Country, region, and city
- Latitude and longitude coordinates
- ISP and organization details
- Timezone information
- Currency and calling code
- EU member status

The API works without an API key for basic usage (limited requests per day), or you can provide an API key for higher rate limits.

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `IPAPI_API_KEY` | Your ipapi.co API key (optional for free tier) | No |

## How to Use

### Run the Job

The job is configured with Google's DNS server (8.8.8.8) as a test IP in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ip` | text | No | IP address to lookup. If not provided, uses the request's remote IP |
| `fields` | text | No | Comma-separated list of specific fields to return |

### Response

```json
{
  "success": true,
  "ip": "8.8.8.8",
  "location": {
    "ip": "8.8.8.8",
    "city": "Mountain View",
    "region": "California",
    "region_code": "CA",
    "country": "US",
    "country_name": "United States",
    "country_code": "US",
    "country_code_iso3": "USA",
    "continent_code": "NA",
    "in_eu": false,
    "postal": "94043",
    "latitude": 37.4229,
    "longitude": -122.085,
    "timezone": "America/Los_Angeles",
    "utc_offset": "-0800",
    "country_calling_code": "+1",
    "currency": "USD",
    "languages": "en-US,es-US,haw,fr",
    "asn": "AS15169",
    "org": "Google Public DNS"
  },
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "ip": "invalid.ip.address",
  "location": null,
  "error": "Invalid IP address"
}
```

## File Structure

```
ipapi-geolocation/
├── run.xs                          # Run job definition
├── function/
│   └── lookup_ip_location.xs       # Function to lookup IP location
└── README.md                       # This file
```

## API Reference

- [ipapi.co Documentation](https://ipapi.co/api/)
- Free tier: 1,000 requests/day without API key
- Paid plans available for higher rate limits

## Testing

You can test with these IP addresses:
- `8.8.8.8` - Google DNS (Mountain View, CA)
- `1.1.1.1` - Cloudflare DNS (San Francisco, CA)
- `208.67.222.222` - OpenDNS (San Francisco, CA)

## Security Notes

- API key is optional for the free tier
- If using a paid plan, keep your `IPAPI_API_KEY` secure
- Never commit your API key to version control
- Consider implementing rate limiting in your application

## Use Cases

- Geolocation-based content personalization
- Fraud detection and security analysis
- Analytics and user location insights
- Compliance with regional regulations (GDPR, etc.)
- Timezone-aware scheduling
