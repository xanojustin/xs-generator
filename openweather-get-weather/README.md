# OpenWeatherMap - Get Current Weather

A Xano Run Job that fetches current weather data for any city using the [OpenWeatherMap API](https://openweathermap.org/api).

## What This Run Job Does

This run job retrieves real-time weather information including:
- Current temperature and "feels like" temperature
- Weather conditions (clear, cloudy, rain, snow, etc.)
- Humidity and atmospheric pressure
- Wind speed
- Visibility and cloud coverage
- City location (name and country code)

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `OPENWEATHER_API_KEY` | Your OpenWeatherMap API key | Sign up for free at [openweathermap.org/api](https://openweathermap.org/api) |

## How to Use

### 1. Set Up Your Environment Variable

Make sure `OPENWEATHER_API_KEY` is set in your Xano workspace environment variables:
```
OPENWEATHER_API_KEY=your_api_key_here
```

### 2. Run the Job

Execute the run job using the Xano CLI:
```bash
xano run execute ./run.xs
```

Or via the Xano dashboard Job Runner.

### 3. Customize the Input

Edit `run.xs` to change the city and units:
```xs
run.job "OpenWeatherMap - Get Current Weather" {
  main = {
    name: "fetch_weather"
    input: {
      city: "New York"      // Change to any city name
      units: "imperial"     // Options: "imperial" (F), "metric" (C), "standard" (K)
    }
  }
  env = ["OPENWEATHER_API_KEY"]
}
```

## Input Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `city` | text | Yes | - | City name (e.g., "San Francisco", "London", "Tokyo") |
| `units` | text | No | "imperial" | Temperature units: "imperial" (Fahrenheit), "metric" (Celsius), or "standard" (Kelvin) |

## Response Format

```json
{
  "success": true,
  "city": "San Francisco",
  "country": "US",
  "weather": {
    "main": "Clear",
    "description": "clear sky"
  },
  "temperature": {
    "current": 72.5,
    "feels_like": 70.2,
    "unit": "F"
  },
  "humidity": 65,
  "pressure": 1015,
  "wind_speed": 8.5,
  "visibility": 10000,
  "clouds": 0,
  "timestamp": "2026-02-16T22:15:00Z"
}
```

## Error Handling

The function handles common API errors:
- **401 Unauthorized**: Invalid API key
- **404 Not Found**: City not found
- **Other errors**: Returns descriptive error messages

## File Structure

```
openweather-get-weather/
├── run.xs              # Run job configuration
├── function/
│   └── fetch_weather.xs  # Weather fetching function
└── README.md           # This documentation
```

## API Reference

This job uses the OpenWeatherMap Current Weather Data API:
- **Endpoint**: `GET https://api.openweathermap.org/data/2.5/weather`
- **Documentation**: https://openweathermap.org/current

## Free Tier Limits

OpenWeatherMap's free tier includes:
- 1,000 API calls per day
- Current weather data
- 5-day/3-hour forecast (not used here)

## Use Cases

- Weather-based notifications or alerts
- Travel and event planning apps
- IoT temperature control systems
- Data logging and analytics
- Dynamic content based on local weather
