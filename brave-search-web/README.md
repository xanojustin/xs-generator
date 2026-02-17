# Brave Search - Web Search

A Xano Run Job that performs web searches using the [Brave Search API](https://brave.com/search/api/).

## What This Run Job Does

This run job performs web searches and returns structured results including:
- Web page titles and URLs
- Page descriptions/snippets
- Publication dates (when available)
- Source/domain information
- Query metadata (original vs altered queries)

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `BRAVE_API_KEY` | Your Brave Search API key | Sign up at [brave.com/search/api](https://brave.com/search/api) |

## How to Use

### 1. Set Up Your Environment Variable

Make sure `BRAVE_API_KEY` is set in your Xano workspace environment variables:
```
BRAVE_API_KEY=your_api_key_here
```

### 2. Run the Job

Execute the run job using the Xano CLI:
```bash
xano run execute ./run.xs
```

Or via the Xano dashboard Job Runner.

### 3. Customize the Input

Edit `run.xs` to change the search query and parameters:
```xs
run.job "Brave Search - Web Search" {
  main = {
    name: "brave_web_search"
    input: {
      query: "machine learning tutorials"    // Any search query
      count: 10                              // Number of results (1-20)
      search_lang: "en"                      // Language code (e.g., "en", "es", "fr")
      country: "US"                          // Country code for localized results
    }
  }
  env = ["BRAVE_API_KEY"]
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | text | Yes | - | Search query string (e.g., "Xano API documentation") |
| `count` | int | No | 10 | Number of results to return (max 20) |
| `search_lang` | text | No | "en" | Language code for search results (ISO 639-1) |
| `country` | text | No | "US" | Country code for localized results (ISO 3166-1 alpha-2) |

## Response Format

```json
{
  "success": true,
  "query": {
    "original": "Xano no-code backend platform",
    "altered": null,
    "show_strict_warning": false
  },
  "results_count": 10,
  "results": [
    {
      "title": "Xano | The No-Code Backend Platform",
      "url": "https://www.xano.com",
      "description": "Build scalable backends without code. Xano provides a complete backend solution...",
      "published_date": "2 weeks ago",
      "source": "Xano"
    },
    {
      "title": "Xano Documentation - Getting Started",
      "url": "https://docs.xano.com",
      "description": "Learn how to build powerful backends with Xano's no-code platform...",
      "published_date": "1 month ago",
      "source": "Xano Documentation"
    }
  ],
  "timestamp": "2026-02-17T11:45:00Z"
}
```

## Error Handling

The function handles common API errors:
- **401 Unauthorized**: Invalid API key
- **429 Rate Limit**: Quota exceeded
- **422 Validation Error**: Invalid search parameters
- **Other errors**: Returns descriptive error messages

## File Structure

```
brave-search-web/
├── run.xs                    # Run job configuration
├── function/
│   └── brave_search.xs       # Search function
└── README.md                 # This documentation
```

## API Reference

This job uses the Brave Web Search API:
- **Endpoint**: `GET https://api.search.brave.com/res/v1/web/search`
- **Documentation**: https://api.search.brave.com/api/swagger

## Free Tier Limits

Brave Search API free tier includes:
- 2,000 queries per month
- Web search results
- News search results (not used here)
- Image search results (not used here)

Paid tiers available for higher volume.

## Use Cases

- AI-powered search assistants
- Content research and aggregation
- SEO analysis tools
- News monitoring systems
- Competitive research
- Knowledge base building
- Automated fact-checking
- Search result caching

## Privacy Note

Brave Search is privacy-focused and does not track users or store search history. The API respects user privacy while providing high-quality search results.
