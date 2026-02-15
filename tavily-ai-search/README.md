# Tavily AI Search Run Job

This Xano Run Job performs AI-powered web searches using the [Tavily API](https://tavily.com).

## What It Does

The run job executes a search query against Tavily's AI search engine, which combines traditional web search with AI-powered result aggregation. It returns search results, optional AI-generated answers, and can include images.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `tavily_api_key` | Your Tavily API key. Get one at https://tavily.com |

## How to Use

### Basic Usage

The run job is configured in `run.xs` with default parameters:

```xs
run.job "Tavily AI Search" {
  main = {
    name: "tavily_search"
    input: {
      query: "latest developments in artificial intelligence"
      search_depth: "advanced"
      max_results: 5
      include_answer: true
    }
  }
  env = ["tavily_api_key"]
}
```

### Function Parameters

The `tavily_search` function accepts these inputs:

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `query` | text | Yes | - | The search query string |
| `search_depth` | text | No | "basic" | Search depth: "basic" or "advanced" |
| `max_results` | int | No | 5 | Maximum number of results (1-20) |
| `include_answer` | bool | No | false | Include AI-generated answer |
| `include_images` | bool | No | false | Include image results |
| `include_raw_content` | bool | No | false | Include raw page content |

### Response Format

```json
{
  "query": "latest developments in artificial intelligence",
  "search_depth": "advanced",
  "result_count": 5,
  "answer": "AI-generated summary of results...",
  "results": [
    {
      "title": "Result Title",
      "url": "https://example.com/article",
      "content": "Snippet of content...",
      "score": 0.95
    }
  ],
  "images": [...],
  "response_time": "2.34s"
}
```

## Files

- `run.xs` - Run job configuration
- `function/tavily_search.xs` - Main search function

## API Documentation

- Tavily Docs: https://docs.tavily.com
