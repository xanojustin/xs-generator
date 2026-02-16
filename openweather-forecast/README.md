# OpenWeatherMap Weather Check Run Job

This XanoScript project fetches current weather data from the OpenWeatherMap API. It demonstrates how to integrate external weather APIs into Xano using scheduled tasks and reusable functions.

## What This Run Job Does

The weather check job:
1. Fetches current weather data for a specified city from OpenWeatherMap
2. Retrieves temperature, humidity, pressure, wind speed, and weather conditions
3. Validates the API response and handles errors gracefully
4. Logs successful fetches for monitoring

## Files

| File | Description |
|------|-------------|
| `function/fetch_weather.xs` | Reusable function that calls the OpenWeatherMap API |
| `task/weather_check.xs` | Scheduled task that runs the weather check (runs the API call directly) |

## Required Environment Variables

| Variable | Description | How to Get |
|----------|-------------|------------|
| `OPENWEATHER_API_KEY` | Your OpenWeatherMap API key | Sign up at [openweathermap.org](https://openweathermap.org/api) |

## How to Use

### 1. Set Up Environment Variables

In your Xano workspace, add the `OPENWEATHER_API_KEY` environment variable with your API key.

### 2. Deploy the Code

Push these files to your Xano workspace using the Xano CLI:

```bash
xano push
```

### 3. Run the Function

You can call the `fetch_weather` function directly:

```xs
fetch_weather {
  city = "New York"
  units = "imperial"  // or "metric" for Celsius
}
```

### 4. Schedule the Task

The `weather_check` task can be scheduled in Xano to run periodically (e.g., every hour):

1. Go to **Tasks** in your Xano workspace
2. Find the `weather_check` task
3. Set the schedule (cron expression)
4. Enable the task

## API Response Format

The function returns the full OpenWeatherMap API response, which includes:

```json
{
  "name": "San Francisco",
  "sys": { "country": "US" },
  "main": {
    "temp": 72.5,
    "feels_like": 70.2,
    "humidity": 65,
    "pressure": 1015
  },
  "weather": [{ "description": "clear sky" }],
  "wind": { "speed": 5.2 },
  "dt": 1708108800
}
```

## Customization

### Change the Default City

Edit `task/weather_check.xs` and modify the city parameter in the API URL.

### Add More Cities

Create additional tasks or modify the function to accept an array of cities.

### Store Results in Database

Extend the task to store weather data in a Xano table for historical tracking:

```xs
db.weather_logs.add {
  city = $weather_response.response.result.name
  temperature = $weather_response.response.result.main.temp
  timestamp = $weather_response.response.result.dt
}
```

## Error Handling

The job includes validation to ensure:
- API key is present (via environment variable)
- API returns a successful HTTP status (200-299)
- Meaningful error messages are logged on failure

## Rate Limits

OpenWeatherMap free tier allows:
- 60 calls/minute
- 1,000,000 calls/month

Adjust your schedule accordingly to stay within limits.

## Resources

- [OpenWeatherMap API Docs](https://openweathermap.org/current)
- [XanoScript Documentation](https://docs.xano.com)
