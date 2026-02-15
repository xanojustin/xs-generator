# Google Maps Geocode Address

A Xano Run Job that geocodes addresses using the Google Maps Geocoding API. Converts human-readable addresses into geographic coordinates (latitude/longitude).

## What It Does

This run job takes a street address and returns:
- **Formatted Address** - The canonical address as recognized by Google
- **Place ID** - Google's unique identifier for the location
- **Latitude** - The geographic latitude coordinate
- **Longitude** - The geographic longitude coordinate  
- **Location Type** - Precision indicator (ROOFTOP, RANGE_INTERPOLATED, GEOMETRIC_CENTER, APPROXIMATE)
- **Partial Match** - Boolean indicating if the match was partial

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `google_maps_api_key` | Your Google Maps Platform API key with Geocoding API enabled |

## How to Use

### Run with Default Address

```bash
xano run execute --job "Google Maps Geocode Address"
```

### Run with Custom Address

Modify the `input.address` value in `run.xs`:

```xs
run.job "Google Maps Geocode Address" {
  main = {
    name: "geocode_address"
    input: {
      address: "1 Infinite Loop, Cupertino, CA"
    }
  }
  env = ["google_maps_api_key"]
}
```

## Example Response

```json
{
  "formatted_address": "1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",
  "place_id": "ChIJ2eUgeAK6j4ARbn5u_wAGqWA",
  "latitude": 37.4224764,
  "longitude": -122.0842499,
  "location_type": "ROOFTOP",
  "partial_match": false
}
```

## Setup Requirements

1. Get a Google Maps Platform API key from [Google Cloud Console](https://console.cloud.google.com/)
2. Enable the **Geocoding API** for your project
3. Set the `google_maps_api_key` environment variable in your Xano workspace

## API Documentation

- [Google Maps Geocoding API](https://developers.google.com/maps/documentation/geocoding/overview)
