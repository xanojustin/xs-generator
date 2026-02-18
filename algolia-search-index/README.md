# Algolia Search Index Run Job

This XanoScript run job demonstrates indexing records to Algolia and performing searches. Algolia is a powerful hosted search API used by developers to build fast, relevant search experiences.

## What This Run Job Does

1. **Saves sample product records** to an Algolia index using `cloud.algolia.save_objects`
2. **Searches the index** for products matching a query using `cloud.algolia.search`
3. **Returns search results** with hits, facets, and metadata

## Use Cases

- Product catalog search
- Documentation search
- User directory search
- Content discovery
- E-commerce search with filters

## Required Environment Variables

| Variable | Description | Required For |
|----------|-------------|--------------|
| `ALGOLIA_APP_ID` | Your Algolia application ID | All operations |
| `ALGOLIA_API_KEY` | Your Algolia Admin API Key (for indexing) | save_objects |
| `ALGOLIA_SEARCH_KEY` | Your Algolia Search API Key (for searching) | search |

## How to Use

### 1. Set up your Algolia account
- Sign up at https://www.algolia.com
- Create an index (e.g., "products")
- Get your App ID and API keys from the dashboard

### 2. Configure environment variables
Set these in your Xano workspace environment variables:
```
ALGOLIA_APP_ID=your_app_id
ALGOLIA_API_KEY=your_admin_api_key
ALGOLIA_SEARCH_KEY=your_search_api_key
```

### 3. Run the job
```bash
# Using Xano CLI
xano run execute run.job --name "Algolia Search Index Demo"

# Or via Xano Run API
POST https://app.dev.xano.com/api:run/run/execute
{
  "job": "Algolia Search Index Demo",
  "input": {
    "index_name": "products",
    "search_query": "laptop"
  }
}
```

## Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `index_name` | text | "products" | Name of the Algolia index |
| `search_query` | text | "*" | Search query (use "*" for all) |
| `max_results` | int | 10 | Maximum number of results to return |

## Output

The function returns an object containing:

```json
{
  "indexed_count": 3,
  "search_results": {
    "hits": [...],
    "nbHits": 15,
    "page": 0,
    "nbPages": 2
  }
}
```

## Files

- `run.xs` - Run job configuration
- `function/index_and_search.xs` - Main function that indexes and searches

## Algolia Features Demonstrated

- **Batch indexing**: `cloud.algolia.save_objects` for efficient bulk operations
- **Full-text search**: `cloud.algolia.search` with query parameters
- **Faceted search**: Support for category/brand filters
- **Pagination**: Control over results per page

## Learn More

- [Algolia Documentation](https://www.algolia.com/doc/)
- [XanoScript Search Integration Docs](https://docs.xano.com)
