# NewsAPI Get Headlines Run Job

This XanoScript run job fetches top news headlines from the [NewsAPI](https://newsapi.org/) service.

## What It Does

This run job retrieves current news headlines from thousands of news sources worldwide. It supports:

- Fetching top headlines by country
- Filtering by news category (technology, business, sports, etc.)
- Keyword search within headlines
- Limiting the number of results
- Filtering by specific news sources
- Multi-language support

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `NEWSAPI_KEY` | Your NewsAPI API key (get free at [newsapi.org](https://newsapi.org/)) |

## How to Use

### Run the Job

The job is configured with test values in `run.xs`. Modify the input values or override them at runtime.

### Function Input Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `country` | text | No | 2-letter ISO country code (default: `us`). Examples: `us`, `gb`, `ca`, `au`, `de` |
| `category` | text | No | News category: `business`, `entertainment`, `general`, `health`, `science`, `sports`, `technology` |
| `query` | text | No | Search keywords to filter articles (e.g., `"artificial intelligence"`, `"climate change"`) |
| `page_size` | text | No | Number of articles to return 1-100 (default: `10`) |
| `sources` | text | No | Comma-separated news source IDs (e.g., `bbc-news,cnn,techcrunch`). **Note:** Cannot be used with `country` or `category` |
| `language` | text | No | 2-letter language code (default: `en`). Examples: `en`, `es`, `fr`, `de`, `ar` |

### Response

```json
{
  "success": true,
  "status": "ok",
  "total_results": 38,
  "articles": [
    {
      "source": {
        "id": "techcrunch",
        "name": "TechCrunch"
      },
      "author": "John Doe",
      "title": "AI Breakthrough Announced",
      "description": "Scientists have made a major advancement in AI technology...",
      "url": "https://techcrunch.com/2024/...",
      "urlToImage": "https://techcrunch.com/image.jpg",
      "publishedAt": "2024-01-15T10:30:00Z",
      "content": "Full article content preview..."
    }
  ],
  "error": null
}
```

### Error Response

```json
{
  "success": false,
  "status": "error",
  "total_results": 0,
  "articles": [],
  "error": "apiKeyInvalid: Your API key is invalid or incorrect. Check your key..."
}
```

## File Structure

```
newsapi-get-headlines/
├── run.xs                    # Run job definition
├── function/
│   └── get_headlines.xs      # Function to fetch headlines
├── README.md                 # This file
└── FEEDBACK.md               # Development feedback
```

## NewsAPI Reference

- [Documentation](https://newsapi.org/docs)
- [Endpoints](https://newsapi.org/docs/endpoints)
- [Sources](https://newsapi.org/docs/endpoints/sources)

## Available Categories

- `business` - Business news
- `entertainment` - Entertainment news
- `general` - General news (default)
- `health` - Health and medical news
- `science` - Science news
- `sports` - Sports news
- `technology` - Technology news

## Popular Country Codes

| Code | Country |
|------|---------|
| `us` | United States |
| `gb` | United Kingdom |
| `ca` | Canada |
| `au` | Australia |
| `de` | Germany |
| `fr` | France |
| `in` | India |
| `jp` | Japan |

## Rate Limits

- **Developer (Free)**: 100 requests/day
- **Business**: Higher limits available

## Security Notes

- Never commit your `NEWSAPI_KEY` to version control
- Use environment variables for API keys
- Consider implementing caching to reduce API calls
- The free tier has limited daily requests

## Example Use Cases

1. **Daily News Digest**: Schedule this job to run daily and email a summary of tech news
2. **Content Aggregation**: Build a news aggregator app with filtered topics
3. **Trending Topics**: Monitor headlines for specific keywords in your industry
4. **Social Media Bot**: Post daily headlines to Twitter/Discord
