# Redis Cache Operations

A Xano Run Job that demonstrates common Redis cache operations including get, set, delete, increment, and decrement.

## What It Does

This run job provides a practical example of using Redis as a caching layer in Xano. It supports:

- **set** - Store a value with optional TTL (time to live)
- **get** - Retrieve a cached value
- **delete** - Remove a key from cache
- **incr** - Increment a counter
- **decr** - Decrement a counter
- **demo** - Run a full demonstration of all operations

## Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `REDIS_URL` | Redis connection URL | `redis://localhost:6379` or `redis://user:pass@host:port` |

## How to Use

### Run the Demo

The demo mode runs through all cache operations automatically:

```bash
# Via Xano Run API
POST /api:run/redis-cache-operations
{
  "operation": "demo"
}
```

### Set a Value

```json
{
  "operation": "set",
  "key": "user:123:profile",
  "value": { "name": "John", "email": "john@example.com" },
  "ttl": 3600
}
```

### Get a Value

```json
{
  "operation": "get",
  "key": "user:123:profile"
}
```

### Delete a Key

```json
{
  "operation": "delete",
  "key": "user:123:profile"
}
```

### Increment a Counter

```json
{
  "operation": "incr",
  "key": "page_views:homepage",
  "amount": 1
}
```

### Decrement a Counter

```json
{
  "operation": "decr",
  "key": "inventory:sku-456",
  "amount": 1
}
```

## Folder Structure

```
~/xs/redis-cache-operations/
├── run.xs                    # Run job configuration
├── function/
│   └── cache_operations.xs   # Main function with all operations
└── README.md                 # This file
```

## Use Cases

- **Session Storage** - Cache user sessions for faster auth lookups
- **API Response Caching** - Cache expensive API responses
- **Rate Limiting** - Track request counts per user/IP
- **Counter Metrics** - Page views, inventory counts, etc.
- **Temporary Data** - Store data that expires automatically

## Notes

- TTL defaults to 3600 seconds (1 hour) if not specified
- The `amount` parameter for incr/decr defaults to 1
- All operations return JSON responses with operation status
