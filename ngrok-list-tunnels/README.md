# Ngrok List Tunnels - Xano Run Job

This Xano Run Job lists all active tunnels from your ngrok account using the ngrok API. It demonstrates how to integrate with ngrok's tunnel management service from Xano.

## What This Run Job Does

The `Ngrok List Tunnels` run job retrieves information about all active ngrok tunnels by:
1. Making an authenticated GET request to ngrok's `/tunnels` endpoint
2. Returning a formatted list of tunnel details including public URLs, regions, and metadata

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `ngrok_api_key` | Your ngrok API Key | `ngk_...` |

### Getting Your ngrok API Key

1. Log in to your [ngrok Dashboard](https://dashboard.ngrok.com)
2. Go to **API** → **Your Authtoken** or create a new API key
3. Copy your API key (starts with `ngk_` or use your authtoken)

## How to Use

### Running the Job

```bash
# Using the Xano CLI
xano run execute --job "Ngrok List Tunnels"

# Or via the Xano Run API
POST https://app.dev.xano.com/api:run/run
{
  "job_name": "Ngrok List Tunnels"
}
```

### Viewing Active Tunnels

The run job returns all active tunnels for your ngrok account:

```json
{
  "tunnel_count": 2,
  "tunnels": [
    {
      "id": "tn_2abc123...",
      "public_url": "https://abc123.ngrok.io",
      "started_at": "2024-01-15T10:30:00Z",
      "metadata": {
        "name": "web-server"
      },
      "region": "us",
      "proto": "https",
      "forwards_to": "http://localhost:3000"
    },
    {
      "id": "tn_2def456...",
      "public_url": "tcp://0.tcp.ngrok.io:12345",
      "started_at": "2024-01-15T11:00:00Z",
      "metadata": {},
      "region": "eu",
      "proto": "tcp",
      "forwards_to": "localhost:22"
    }
  ]
}
```

## File Structure

```
ngrok-list-tunnels/
├── run.xs                              # Run job configuration
├── function/
│   └── list_ngrok_tunnels.xs           # Function that calls ngrok API
└── README.md                           # This file
```

## Response Format

On success, the function returns a formatted response:

```json
{
  "tunnel_count": 1,
  "tunnels": [
    {
      "id": "tn_2ABC123DEF456",
      "public_url": "https://abc123def456.ngrok.io",
      "started_at": "2024-01-15T10:30:00Z",
      "metadata": {
        "name": "my-app"
      },
      "region": "us",
      "proto": "https",
      "forwards_to": "http://localhost:8080",
      "endpoint": {
        "id": "ep_2ABC123DEF456",
        "uri": "https://api.ngrok.com/endpoints/ep_2ABC123DEF456"
      }
    }
  ]
}
```

### Tunnel Object Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | string | Unique identifier for the tunnel |
| `public_url` | string | The public URL to access your tunnel |
| `started_at` | string | ISO 8601 timestamp when the tunnel started |
| `metadata` | object | User-defined metadata for the tunnel |
| `region` | string | The ngrok region where the tunnel is hosted |
| `proto` | string | Protocol (https, http, tcp, tls) |
| `forwards_to` | string | The local address the tunnel forwards to |
| `endpoint` | object | Endpoint configuration details |

## Error Handling

The function throws a `NgrokAPIError` if:
- The ngrok API returns a non-2xx status code
- The request times out
- Authentication fails (invalid API key)
- Rate limits are exceeded

Common error responses:
- `401 Unauthorized` - Invalid or missing API key
- `429 Too Many Requests` - Rate limit exceeded
- `500 Internal Server Error` - ngrok service error

## Security Notes

- **Never commit your ngrok API key** - always use environment variables
- ngrok API keys start with `ngk_` (newer format) or use your authtoken
- Keep your API key secure as it provides access to your tunnel configurations
- Consider rotating your API keys periodically

## Use Cases

- **Monitoring**: Keep track of active tunnels across your team
- **Automation**: Integrate tunnel status into your deployment pipelines
- **Alerting**: Check for unexpected tunnels and trigger alerts
- **Documentation**: Generate reports of active development environments

## ngrok CLI Alternative

You can also list tunnels using the ngrok CLI:

```bash
# List all tunnels
ngrok api tunnels list

# Get specific tunnel details
ngrok api tunnels get tn_<tunnel_id>
```

## Additional Resources

- [ngrok API Documentation](https://ngrok.com/docs/api/resources/tunnels/)
- [ngrok CLI Documentation](https://ngrok.com/docs/ngrok-agent/)
- [XanoScript Documentation](https://docs.xano.com)

## Rate Limits

The ngrok API has rate limits based on your plan:
- **Free**: 40 requests per minute
- **Pay-as-you-go**: 120 requests per minute
- **Enterprise**: Custom limits

If you exceed the rate limit, the API will return a `429` status code.
