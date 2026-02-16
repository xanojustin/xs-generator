# Yelp Business Search Run Job

A Xano Run Job that searches for businesses using the Yelp Fusion API.

## What This Run Job Does

This run job searches for businesses on Yelp based on search criteria like location, business type, price range, and more. It returns detailed information about matching businesses including ratings, reviews, contact info, photos, and location data.

## Prerequisites

1. **Yelp Fusion API Key**: You need a Yelp Fusion API key from [Yelp Fusion](https://fusion.yelp.com/)
   - Sign up for a free Yelp account
   - Create a new app in the Yelp Fusion console
   - Copy your API key

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `yelp_api_key` | Your Yelp Fusion API key |

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `term` | text | Yes | - | Search term (e.g., "coffee", "restaurants", "plumbers") |
| `location` | text | Yes | - | Location to search (e.g., "San Francisco, CA") |
| `limit` | int | No | 10 | Number of results to return (max 50) |
| `sort_by` | text | No | "best_match" | Sort by: best_match, rating, review_count, distance |
| `price` | text | No | "1,2,3,4" | Price levels: 1=$, 2=$$, 3=$$$, 4=$$$$ (comma-separated) |
| `open_now` | text | No | "false" | Filter by open now: "true" or "false" |

## Usage

### Basic Example
Search for coffee shops in San Francisco:

```json
{
  "term": "coffee",
  "location": "San Francisco, CA",
  "limit": 5
}
```

### Advanced Example
Search for expensive Italian restaurants in NYC that are currently open, sorted by rating:

```json
{
  "term": "italian",
  "location": "New York, NY",
  "limit": 20,
  "sort_by": "rating",
  "price": "3,4",
  "open_now": "true"
}
```

## Response Structure

```json
{
  "search_params": {
    "term": "coffee",
    "location": "San Francisco, CA",
    "limit": 10,
    "sort_by": "best_match"
  },
  "total_results": 1234,
  "returned_count": 10,
  "region_center": {
    "latitude": 37.7749,
    "longitude": -122.4194
  },
  "businesses": [
    {
      "id": "abc123",
      "name": "Blue Bottle Coffee",
      "image_url": "https://...",
      "url": "https://www.yelp.com/...",
      "review_count": 523,
      "rating": 4.5,
      "price": "$$",
      "phone": "+14155551234",
      "display_phone": "(415) 555-1234",
      "distance": 0.3,
      "categories": ["Coffee & Tea", "Cafes"],
      "location": {
        "address1": "123 Main St",
        "city": "San Francisco",
        "zip_code": "94102",
        "country": "US",
        "state": "CA",
        "display_address": ["123 Main St", "San Francisco, CA 94102"]
      },
      "coordinates": {
        "latitude": 37.7749,
        "longitude": -122.4194
      },
      "is_closed": false
    }
  ]
}
```

## Rate Limits

Yelp Fusion API has the following limits:
- **Daily limit**: 500 requests per day (free tier)
- Check [Yelp Fusion documentation](https://docs.developer.yelp.com/docs/fusion-intro) for current limits

## API Documentation

- [Yelp Fusion API Docs](https://docs.developer.yelp.com/docs/fusion-intro)
- [Business Search Endpoint](https://docs.developer.yelp.com/reference/v3_business_search)

## File Structure

```
yelp-search-businesses/
├── run.xs                     # Run job configuration
├── function/
│   └── search_businesses.xs   # Business search function
└── README.md                  # This file
```

## Notes

- Distance is converted from meters to miles in the response
- The `price` field returns null for businesses without price data
- Image URLs may expire; use them promptly or cache images as needed
- Always respect Yelp's Terms of Service when using this data
