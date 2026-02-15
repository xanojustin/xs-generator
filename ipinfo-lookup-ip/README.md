# IPInfo IP Intelligence Lookup Run Job

This XanoScript run job looks up detailed IP intelligence data using the [ipinfo.io](https://ipinfo.io) API.

## What It Does

This run job retrieves comprehensive intelligence data for any IP address, including:

- **Geolocation**: Country, region, city, postal code
- **Coordinates**: Latitude and longitude
- **Network**: ASN (Autonomous System Number), organization name
- **Company**: Company name and domain (if available)
- **Carrier**: Mobile carrier information (for mobile IPs)
- **Privacy**: VPN, proxy, tor, relay detection (with paid plans)
- **Timezone**: Local timezone for the IP

The API provides a generous free tier with essential data, and paid plans unlock advanced features like privacy detection and bulk lookups.

## Required Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `IPINFO_API_KEY` | Your ipinfo.io API token (optional for basic usage) | No |

## How to Use

### Run the Job

The job is configured with Google's DNS server (8.8.8.8) as a test IP in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `ip` | text | No | IP address to lookup. If not provided, uses the request's remote IP |

### Response

```json
{
  "success": true,
  "ip": "8.8.8.8",
  "data": {
    "ip": "8.8.8.8",
    "city": "Mountain View",
    "region": "California",
    "country": "US",
    "loc": "37.3860,-122.0838",
    "org": "AS15169 Google LLC",
    "postal": "94043",
    "timezone": "America/Los_Angeles"
  },
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "ip": "invalid.ip.address",
  "data": null,
  "error": "Invalid IP address"
}
```

## File Structure

```
ipinfo-lookup-ip/
├── run.xs                          # Run job definition
├── function/
│   └── lookup_ip_info.xs           # Function to lookup IP intelligence
├── README.md                       # This file
└── FEEDBACK.md                     # Xano MCP feedback documentation
```

## API Reference

- [ipinfo.io Documentation](https://ipinfo.io/developers)
- Free tier: 50,000 requests/month without API key (rate limited)
- Paid plans available for:
  - Higher rate limits
  - Privacy detection (VPN, proxy, tor)
  - Company and carrier details
  - Bulk lookup support
  - SLA and support

## Testing

You can test with these IP addresses:
- `8.8.8.8` - Google DNS (Mountain View, CA)
- `1.1.1.1` - Cloudflare DNS (San Francisco, CA)
- `208.67.222.222` - OpenDNS (San Francisco, CA)
- `9.9.9.9` - Quad9 (Berkeley, CA)

## Security Notes

- API token is optional for basic usage (free tier includes 50K requests/month)
- If using a paid plan, keep your `IPINFO_API_KEY` secure
- Never commit your API key to version control
- Consider implementing rate limiting in your application

## Use Cases

- **Security & Fraud Prevention**: Detect VPNs, proxies, and suspicious IPs
- **Content Personalization**: Show location-specific content
- **Analytics**: Track user locations and ISP information
- **Compliance**: Geoblocking and regional restrictions
- **Network Analysis**: ASN and organization identification
- **Mobile Targeting**: Carrier information for mobile campaigns