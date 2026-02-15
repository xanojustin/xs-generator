# Algolia Search Index Run Job

This Xano Run Job performs searches against an Algolia search index using their Search API.

## What It Does

The run job searches an Algolia index and returns matching results with metadata including:
- Search hits (results)
- Total hit count
- Pagination info (current page, total pages)
- Processing time

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `ALGOLIA_APP_ID` | Your Algolia Application ID |
| `ALGOLIA_API_KEY` | Your Algolia Admin API Key (or Search API Key) |
| `ALGOLIA_SEARCH_KEY` | (Optional) Dedicated Search-only API Key for better security |

## Usage

### Basic Search

```xs
run.job "Search Products" {
  main = {
    name: "search_index"
    input: {
      query: "laptop"
      index_name: "products"
      hits_per_page: 10
    }
  }
  env = ["ALGOLIA_APP_ID", "ALGOLIA_API_KEY"]
}
```

### With Filters

```xs
run.job "Search Electronics" {
  main = {
    name: "search_index"
    input: {
      query: "phone"
      index_name: "products"
      hits_per_page: 20
      filters: "category:electronics AND price < 500"
      attributes_to_retrieve: "name,price,category,image"
    }
  }
  env = ["ALGOLIA_APP_ID", "ALGOLIA_API_KEY"]
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | text | Yes | - | Search query string |
| `index_name` | text | Yes | - | Name of the Algolia index |
| `hits_per_page` | int | No | 10 | Number of results per page |
| `page` | int | No | 0 | Page number (0-indexed) |
| `filters` | text | No | - | Algolia filter query (e.g., `category:electronics`) |
| `attributes_to_retrieve` | text | No | - | Comma-separated attributes to return |

## Response Format

```json
{
  "success": true,
  "query": "laptop",
  "hits": [
    {
      "objectID": "12345",
      "name": "MacBook Pro",
      "price": 1999,
      "_highlightResult": { ... }
    }
  ],
  "total_hits": 42,
  "page": 0,
  "total_pages": 5,
  "processing_time_ms": 12,
  "error": null
}
```

## File Structure

```
algolia-search-index/
├── run.xs              # Run job configuration
├── function/
│   └── search_index.xs # Search implementation
└── README.md           # This file
```

## API Reference

This job uses the Algolia Search API:
- Endpoint: `https://{APP_ID}-dsn.algolia.net/1/indexes/{INDEX_NAME}/query`
- Method: POST
- Headers: `X-Algolia-Application-Id`, `X-Algolia-API-Key`

## Getting Algolia Credentials

1. Sign up at [algolia.com](https://www.algolia.com)
2. Create an index and add some records
3. Find your Application ID in the Dashboard → API Keys
4. Use your Search API Key for searching (recommended) or Admin API Key

## Error Handling

The job handles common errors:
- Missing environment variables
- Invalid/missing query or index name
- Algolia API errors (returns error message in response)
