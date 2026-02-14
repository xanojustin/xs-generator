# OpenWeatherMap Get Current Weather

A Xano run job that fetches current weather data from the OpenWeatherMap API.

## What This Run Job Does

This run job retrieves real-time weather information for any city worldwide using the OpenWeatherMap Current Weather Data API. It returns:

- Temperature and "feels like" temperature
- Humidity percentage
- Atmospheric pressure
- Weather description (e.g., "clear sky", "light rain")
- Wind speed
- City and country information

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `OPENWEATHER_API_KEY` | Your OpenWeatherMap API key | Sign up at [openweathermap.org](https://openweathermap.org/api) |

## How to Use

### Default Run (London, metric units)
```bash
# Set your API key
export OPENWEATHER_API_KEY="your_api_key_here"

# Run the job
xano run.job run.xs
```

### With Custom Parameters

Modify the `input` block in `run.xs`:

```xs
run.job "OpenWeatherMap Get Current Weather" {
  main = {
    name: "get_current_weather"
    input: {
      city: "New York"
      units: "imperial"  // Options: metric, imperial, kelvin
    }
  }
  env = ["OPENWEATHER_API_KEY"]
}
```

### Parameter Reference

| Parameter | Default | Options | Description |
|-----------|---------|---------|-------------|
| `city` | "London" | Any city name | The city to get weather for |
| `units` | "metric" | metric, imperial, kelvin | Temperature units |

**Unit Options:**
- `metric` - Temperature in Celsius, wind speed in m/s
- `imperial` - Temperature in Fahrenheit, wind speed in mph
- `kelvin` - Temperature in Kelvin, wind speed in m/s

## Response Format

```json
{
  "success": true,
  "city": "London",
  "country": "GB",
  "temperature": 15.5,
  "feels_like": 14.8,
  "humidity": 72,
  "pressure": 1015,
  "description": "scattered clouds",
  "wind_speed": 3.5,
  "units": "metric",
  "error": null
}
```

## File Structure

```
openweather-get-current/
├── run.xs                          # Run job configuration
├── function/
│   └── get_current_weather.xs     # Main function
└── README.md                       # This file
```

## Error Handling

The run job handles various error scenarios:

- Missing API key - Returns error message
- Invalid city name - Returns API error
- API failures - Returns HTTP status and error details

## API Rate Limits

OpenWeatherMap free tier allows:
- 1,000 calls/day
- 60 calls/minute

For production use, consider upgrading to a paid plan.

## Links

- [OpenWeatherMap API Docs](https://openweathermap.org/current)
- [Get API Key](https://home.openweathermap.org/api_keys)
