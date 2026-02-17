# Mapbox Geocode Address

A Xano Run Job that geocodes addresses using the Mapbox Geocoding API. Converts a human-readable address into geographic coordinates (latitude and longitude).

## What This Run Job Does

This run job takes a street address and returns:
- **Geographic coordinates** (latitude and longitude)
- **Formatted place name**
- **Place type** (address, poi, neighborhood, etc.)
- **Address accuracy** information
- **Full API response** for additional details

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `mapbox_access_token` | Your Mapbox public access token | Create a free account at [mapbox.com](https://account.mapbox.com/auth/signup/) |

## How to Use

### Basic Usage

1. Set your Mapbox access token as an environment variable:
   ```
   mapbox_access_token=pk.your_token_here
   ```

2. Run the job:
   ```bash
   xano run
   ```

### Customizing the Input

Edit `run.xs` to change the address:

```xs
run.job "Geocode Address with Mapbox" {
  main = {
    name: "geocode_address"
    input: {
      address: "Your Address Here"
      country: "us"  // Optional: ISO country code for filtering
    }
  }
  env = ["mapbox_access_token"]
}
```

### Function Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `address` | text | Yes | The address to geocode (e.g., "1600 Amphitheatre Parkway, Mountain View, CA") |
| `country` | text | No | ISO 3166-1 alpha-2 country code to filter results (e.g., "us", "ca", "gb") |

## Response Format

```json
{
  "place_name": "1600 Amphitheatre Parkway, Mountain View, California 94043, United States",
  "longitude": -122.084,
  "latitude": 37.422,
  "accuracy": "rooftop",
  "place_type": "address",
  "address": "1600",
  "text": "Amphitheatre Parkway",
  "full_response": { ... }
}
```

## Example Use Cases

- **Store locators**: Convert customer addresses to coordinates for distance calculations
- **Delivery apps**: Validate addresses and get precise coordinates for routing
- **Real estate**: Enrich property listings with geographic data
- **Logistics**: Normalize and standardize address formats

## API Documentation

- [Mapbox Geocoding API Docs](https://docs.mapbox.com/api/search/geocoding/)
- [Mapbox Pricing](https://www.mapbox.com/pricing) - 100,000 free geocoding requests/month

## Files

- `run.xs` - Run job configuration
- `function/geocode_address.xs` - The geocoding function
