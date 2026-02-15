# Upstash Redis Set Key

A Xano Run Job that sets a key-value pair in Upstash Redis using the REST API.

## What This Run Job Does

This run job connects to Upstash Redis (a serverless Redis service) and sets a key with an optional TTL (time-to-live). It's useful for:

- Caching data temporarily
- Storing session information
- Rate limiting counters
- Distributed locks
- Temporary data storage

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `upstash_redis_rest_url` | Your Upstash Redis REST URL | `https://careful-kiwi-12345.upstash.io` |
| `upstash_redis_rest_token` | Your Upstash Redis REST token | `AYPdASQg...` |

### Getting Your Upstash Credentials

1. Sign up at [upstash.com](https://upstash.com)
2. Create a new Redis database
3. Go to the "REST API" tab in your database dashboard
4. Copy the `UPSTASH_REDIS_REST_URL` and `UPSTASH_REDIS_REST_TOKEN`

## How to Use

### Default Usage

The run job comes with default values:
- Key: `demo_key`
- Value: `Hello from Xano Run Job!`
- TTL: `3600` seconds (1 hour)

### Customizing Input

Edit the `run.xs` file to change the input values:

```xs
run.job "Upstash Redis Set Key" {
  main = {
    name: "set_redis_key"
    input: {
      key: "my_custom_key"
      value: "My custom value"
      ttl: 7200  // 2 hours
    }
  }
  env = ["upstash_redis_rest_url", "upstash_redis_rest_token"]
}
```

### Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `key` | text | Yes | - | The Redis key to set |
| `value` | text | Yes | - | The value to store |
| `ttl` | int | No | null | Time-to-live in seconds (omit for no expiration) |

### Response

The function returns:

```json
{
  "success": true,
  "key": "demo_key",
  "value": "Hello from Xano Run Job!",
  "ttl": 3600,
  "redis_response": "OK"
}
```

## File Structure

```
upstash-redis-set-key/
├── run.xs                    # Run job definition
├── function/
│   └── set_redis_key.xs      # Main function logic
└── README.md                 # This file
```

## API Reference

This run job uses the [Upstash Redis REST API](https://docs.upstash.com/redis/features/restapi):

- **Endpoint**: `GET /set/{key}/{value}`
- **Authentication**: Bearer token
- **TTL Support**: Query parameter `?EX={seconds}`

## Error Handling

The function validates:
- Required inputs (key and value)
- Environment variables (REST URL and token)
- HTTP response status from Upstash API

Errors are returned with descriptive messages for easy debugging.

## See Also

- [Upstash Documentation](https://docs.upstash.com/)
- [Upstash Redis REST API Reference](https://docs.upstash.com/redis/features/restapi)
- [Xano Run Jobs Documentation](https://docs.xano.com/run)
