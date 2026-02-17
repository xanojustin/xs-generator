# Cloudflare Create DNS Record Run Job

This Xano Run Job creates a DNS record in Cloudflare using the Cloudflare API.

## What It Does

Creates a new DNS record (A, AAAA, CNAME, MX, TXT, etc.) in a Cloudflare zone. This is useful for:
- Automating DNS management
- Creating subdomains programmatically
- Setting up records for new services
- Bulk DNS operations

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `cloudflare_api_token` | Cloudflare API Token with DNS:Edit permissions |
| `cloudflare_account_id` | Your Cloudflare Account ID (optional for this operation) |

### Getting a Cloudflare API Token

1. Go to https://dash.cloudflare.com/profile/api-tokens
2. Click "Create Token"
3. Use the "Edit zone DNS" template
4. Select the specific zone(s) you want to manage
5. Copy the token value

### Finding Your Zone ID

1. Go to your domain in the Cloudflare dashboard
2. The Zone ID is shown in the right sidebar under "API"

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `zone_id` | text | Yes | - | Cloudflare Zone ID |
| `record_type` | text | Yes | A | DNS record type (A, AAAA, CNAME, MX, TXT, etc.) |
| `name` | text | Yes | - | Record name (e.g., "www", "api", or "@" for root) |
| `content` | text | Yes | - | Record content (IP address, target domain, etc.) |
| `ttl` | int | No | 1 | TTL in seconds (1 = automatic) |
| `proxied` | bool | No | true | Whether to proxy through Cloudflare |

## Usage Examples

### Create an A record
```json
{
  "zone_id": "your-zone-id",
  "record_type": "A",
  "name": "www",
  "content": "192.0.2.1",
  "ttl": 1,
  "proxied": true
}
```

### Create a CNAME record
```json
{
  "zone_id": "your-zone-id",
  "record_type": "CNAME",
  "name": "api",
  "content": "example.com",
  "ttl": 1,
  "proxied": true
}
```

### Create an MX record
```json
{
  "zone_id": "your-zone-id",
  "record_type": "MX",
  "name": "@",
  "content": "mail.example.com",
  "ttl": 3600,
  "proxied": false
}
```

## Response

On success, returns the created DNS record:
```json
{
  "success": true,
  "message": "DNS record created successfully",
  "record": {
    "id": "record-id",
    "type": "A",
    "name": "www.example.com",
    "content": "192.0.2.1",
    "ttl": 1,
    "proxied": true,
    "proxiable": true,
    "created_on": "2024-01-01T00:00:00Z",
    "modified_on": "2024-01-01T00:00:00Z"
  }
}
```

## Error Handling

The run job handles various error cases:
- **400 Bad Request**: Invalid input parameters
- **401 Unauthorized**: Invalid API token
- **403 Forbidden**: Insufficient permissions
- **404 Not Found**: Zone not found

## Files

- `run.xs` - Run job configuration
- `function/create_dns_record.xs` - Main function that creates the DNS record

## Supported Record Types

- A, AAAA, CNAME, MX, TXT, NS
- SRV, PTR, CERT, DNSKEY, DS
- NAPTR, SMIMEA, SSHFP, TLSA, URI

## Learn More

- [Cloudflare API Documentation](https://developers.cloudflare.com/api/operations/dns-records-for-a-zone-create-dns-record)
- [Cloudflare API Tokens](https://developers.cloudflare.com/api/tokens/)
