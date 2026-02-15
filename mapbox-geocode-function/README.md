# Mapbox Geocode Address

A Xano Run Job that geocodes street addresses into geographic coordinates using the Mapbox Geocoding API.

## What This Run Job Does

This run job takes a street address as input and returns detailed geographic information including:

- **Coordinates**: Latitude and longitude
- **Place Name**: Full formatted address
- **Place Type**: Type of location (address, poi, neighborhood, etc.)
- **Relevance**: Match confidence score
- **Context**: Additional geographic context (city, state, country, etc.)

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `mapbox_access_token` | Your Mapbox public access token (starts with `pk.`) |

Get your access token at: https://account.mapbox.com/access-tokens/

## How to Use

### Run with Default Address

```bash
xano run run.xs
```

This will geocode the default address: "1600 Pennsylvania Avenue NW, Washington, DC"

### Run with Custom Address

Modify the `input.address` value in `run.xs`:

```xs
run.job "Mapbox Geocode Address" {
  main = {
    name: "geocode_address"
    input: {
      address: "One Apple Park Way, Cupertino, CA"
    }
  }
  env = ["mapbox_access_token"]
}
```

### Expected Output

```json
{
  "query": "1600 Pennsylvania Avenue NW, Washington, DC",
  "place_name": "1600 Pennsylvania Avenue Northwest, Washington, District of Columbia 20006, United States",
  "longitude": -77.03655,
  "latitude": 38.89768,
  "accuracy": "rooftop",
  "place_type": "address",
  "relevance": 1,
  "address": "1600",
  "text": "Pennsylvania Avenue Northwest",
  "context": [...]
}
```

## Files

- `run.xs` - Run job configuration
- `function/geocode_address.xs` - Main geocoding logic

## API Reference

Uses the Mapbox Geocoding API:
- Endpoint: `https://api.mapbox.com/geocoding/v5/mapbox.places/{address}.json`
- Documentation: https://docs.mapbox.com/api/search/geocoding/

## Error Handling

The function handles the following error cases:
- Missing or empty address input
- API authentication failures
- No results found for the provided address
