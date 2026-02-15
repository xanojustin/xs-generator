# WeatherAPI Current Weather Run Job

This Xano Run Job fetches current weather data for any location using the [WeatherAPI](https://www.weatherapi.com/) service.

## What It Does

The run job retrieves comprehensive current weather information including:
- Temperature (Celsius & Fahrenheit)
- Weather condition and icon
- Humidity percentage
- Wind speed (KPH & MPH) and direction
- Atmospheric pressure
- "Feels like" temperature
- Visibility
- UV index
- Air quality measurements (CO, NO2, O3, SO2, PM2.5, PM10)
- Location details (name, region, country, coordinates, local time)

## Required Environment Variables

| Variable | Description | How to Obtain |
|----------|-------------|---------------|
| `WEATHER_API_KEY` | Your WeatherAPI API key | Sign up at [weatherapi.com](https://www.weatherapi.com/) - free tier includes 1 million calls/month |

## How to Use

### 1. Set Up Environment Variable
In your Xano workspace, set the `WEATHER_API_KEY` environment variable with your API key.

### 2. Customize the Location
Edit `run.xs` and change the `location` input parameter:

```xs
run.job "Fetch Current Weather" {
  main = {
    name: "fetch_current_weather"
    input: {
      location: "New York"  // Change to your desired location
    }
  }
  env = ["WEATHER_API_KEY"]
}
```

### 3. Run the Job
Deploy and run the job in Xano Job Runner.

## Location Format

The location parameter accepts various formats:
- City name: `"London"`
- City with country: `"Paris, France"`
- ZIP/Postal code: `"90210"` or `"SW1A 1AA"`
- Coordinates: `"48.8567,2.3508"`
- Airport code: `"LAX"` or `"JFK"`

## Response Format

```json
{
  "location": {
    "name": "Los Angeles",
    "region": "California",
    "country": "USA",
    "lat": 34.05,
    "lon": -118.24,
    "localtime": "2025-02-15 14:30"
  },
  "current": {
    "temp_c": 22.0,
    "temp_f": 71.6,
    "condition": "Partly cloudy",
    "condition_icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
    "humidity": 45,
    "wind_kph": 15.1,
    "wind_mph": 9.4,
    "wind_dir": "WSW",
    "pressure_mb": 1015.0,
    "feelslike_c": 21.5,
    "feelslike_f": 70.7,
    "vis_km": 16.0,
    "uv": 5.0,
    "air_quality": {
      "co": 230.0,
      "no2": 12.0,
      "o3": 45.0,
      "so2": 2.0,
      "pm2_5": 8.0,
      "pm10": 12.0
    }
  }
}
```

## API Reference

- WeatherAPI Documentation: https://www.weatherapi.com/docs/
- Free tier: 1 million calls per month
- No credit card required for free tier

## File Structure

```
weatherapi-current-weather/
├── run.xs                          # Run job configuration
├── function/
│   └── fetch_current_weather.xs    # Main function
└── README.md                       # This file
```

## Error Handling

The function validates inputs and handles API errors:
- Missing location returns input error
- API failures return descriptive error messages
- Network timeouts are set to 30 seconds
