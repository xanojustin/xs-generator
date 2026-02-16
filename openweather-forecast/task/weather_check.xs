// Scheduled task for fetching weather data
// This task can be scheduled to run periodically via Xano
task "weather_check" {
  stack {
    // Build the API URL with query parameters
    var $api_url {
      value = "https://api.openweathermap.org/data/2.5/weather?q=San%20Francisco&appid=" ~ $env.OPENWEATHER_API_KEY ~ "&units=imperial"
    }

    // Make the API request to OpenWeatherMap
    api.request {
      url = $api_url.value
      method = "GET"
      timeout = 30
    } as $weather_response

    // Validate the response status
    precondition ($weather_response.response.status >= 200 && $weather_response.response.status < 300) {
      error_type = "standard"
      error = "Weather API error: " ~ ($weather_response.response.status|to_text)
    }

    // Log the successful fetch
    debug.log {
      value = "Weather fetched: " ~ ($weather_response.response.result.name|to_text) ~ " - " ~ ($weather_response.response.result.main.temp|to_text) ~ "°F"
    }
  }
}
