# OpenWeather Get Current Weather Run Job

A Xano Run Job that fetches current weather data from the OpenWeather API for any city worldwide.

## What This Run Job Does

This run job demonstrates how to integrate with OpenWeather's Current Weather API from XanoScript. It:

1. Takes a city name as input
2. Calls OpenWeather's `/data/2.5/weather` endpoint
3. Returns comprehensive weather data including:
   - Current temperature and "feels like" temperature
   - Weather conditions (description, icon)
   - Humidity and atmospheric pressure
   - Wind speed and direction
   - Cloud coverage and visibility
   - Sunrise and sunset times
   - Geographic coordinates

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENWEATHER_API_KEY` | Your OpenWeather API key (required) |

Get your free API key at: https://openweathermap.org/api

## How to Use

### Default Usage
The run job comes with default settings for San Francisco:
```xs
run.job "OpenWeather Get Current Weather" {
  main = {
    name: "get_weather"
    input: {
      city: "San Francisco"
      units: "imperial"
      lang: "en"
    }
  }
  env = ["openweather_api_key"]
}
```

### Custom Cities
You can modify the `input` block in `run.xs` to fetch weather for any city:

```xs
input: {
  city: "Tokyo"
  units: "metric"
  lang: "en"
}
```

### Available Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `city` | text | (required) | City name (e.g., "London", "New York", "Tokyo") |
| `units` | text | "metric" | Temperature units: `metric` (°C), `imperial` (°F), or `standard` (K) |
| `lang` | text | "en" | Language code for weather description (e.g., "en", "es", "fr", "de") |

### Supported Languages
OpenWeather supports 30+ languages including:
- `en` - English
- `es` - Spanish
- `fr` - French
- `de` - German
- `it` - Italian
- `ja` - Japanese
- `ko` - Korean
- `zh_cn` - Chinese Simplified
- `ru` - Russian
- `pt` - Portuguese

## File Structure

```
openweather-get-current-weather/
├── run.xs                      # Run job configuration
├── functions/
│   └── get_weather.xs          # Main function that calls OpenWeather API
└── README.md                   # This file
```

## Response Format

```json
{
  "success": true,
  "city": "San Francisco",
  "country": "US",
  "coordinates": {
    "lat": 37.7749,
    "lon": -122.4194
  },
  "weather": {
    "main": "Clear",
    "description": "clear sky",
    "icon": "https://openweathermap.org/img/wn/01d@2x.png",
    "icon_code": "01d"
  },
  "temperature": {
    "current": 68.5,
    "feels_like": 67.8,
    "min": 62.1,
    "max": 72.3,
    "unit": "°F"
  },
  "atmosphere": {
    "humidity": 65,
    "pressure": 1015
  },
  "wind": {
    "speed": 8.5,
    "direction": 280,
    "gust": 15.2,
    "unit": "mph"
  },
  "clouds": 0,
  "visibility": 10000,
  "timestamp": 1707350400,
  "sunrise": 1707309600,
  "sunset": 1707345600
}
```

## Error Handling

The function includes validation for:
- Missing `OPENWEATHER_API_KEY` environment variable
- Invalid city names (API will return 404)
- Invalid unit parameters (must be metric, imperial, or standard)
- Network timeouts (30 second limit)

## Notes

- The API icon URL points to OpenWeather's official icon CDN
- Temperature units are automatically converted based on the `units` parameter
- Sunrise/sunset timestamps are in Unix epoch format
- Free tier allows 60 calls/minute and 1,000,000 calls/month
- City names work best with major cities; for ambiguous names, include country code (e.g., "Paris,FR" vs "Paris,US")
