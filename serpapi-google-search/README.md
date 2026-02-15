# SerpAPI Google Search Run Job

This XanoScript run job performs Google searches using the SerpAPI service and returns organic search results.

## What It Does

This run job searches Google via SerpAPI and returns:

- Organic search results with titles, links, and snippets
- Total number of results found
- Search execution time
- Formatted, clean response data

Perfect for SEO monitoring, rank tracking, content research, and data extraction workflows.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `SERPAPI_API_KEY` | Your SerpAPI API key (get one at [serpapi.com](https://serpapi.com)) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `query` | text | Yes | Search query string (e.g., "xano no code backend") |
| `location` | text | No | Location for localized results (default: "United States") |
| `language` | text | No | Language code (default: "en") |
| `num_results` | text | No | Number of results to return (default: "10", max: "100") |

### Response

```json
{
  "success": true,
  "query": "xano no code backend",
  "total_results": "About 1,230,000 results",
  "search_time": "0.42 seconds",
  "results": [
    {
      "position": 1,
      "title": "Xano - The No-Code Backend Platform",
      "link": "https://www.xano.com",
      "snippet": "Xano is the fastest way to build a scalable backend for your application...",
      "displayed_link": "https://www.xano.com"
    },
    {
      "position": 2,
      "title": "Xano Documentation",
      "link": "https://docs.xano.com",
      "snippet": "Complete documentation for the Xano platform...",
      "displayed_link": "https://docs.xano.com"
    }
  ],
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "query": "test query",
  "total_results": null,
  "search_time": null,
  "results": [],
  "error": "SerpAPI error: Invalid API key"
}
```

## File Structure

```
serpapi-google-search/
├── run.xs                    # Run job definition
├── function/
│   └── search_google.xs      # Function to search Google
├── README.md                 # This file
└── FEEDBACK.md              # Development feedback
```

## SerpAPI Reference

- [SerpAPI Documentation](https://serpapi.com/docs)
- [Google Search API](https://serpapi.com/google-search-api)
- [Pricing](https://serpapi.com/pricing) - Free tier includes 100 searches/month

## Use Cases

- **SEO Monitoring**: Track keyword rankings over time
- **Content Research**: Find top-ranking content for topics
- **Competitive Analysis**: Monitor competitor search presence
- **Lead Generation**: Extract business information from search results
- **Market Research**: Analyze search trends and results

## Rate Limits

SerpAPI has different rate limits based on your plan:
- Free: 100 searches/month
- Developer: 5,000 searches/month
- Production: 30,000+ searches/month

## Security Notes

- Never commit your `SERPAPI_API_KEY` to version control
- Use environment variables or Xano's secure environment configuration
- Consider implementing caching to reduce API calls
