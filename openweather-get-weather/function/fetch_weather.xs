function "fetch_weather" {
  input {
    text city filters=trim
    text units?="imperial"
  }
  
  stack {
    // Validate required inputs
    precondition ($input.city != null && $input.city != "") {
      error_type = "inputerror"
      error = "City name is required"
    }
    
    // Build the API URL with query parameters
    var $api_url {
      value = "https://api.openweathermap.org/data/2.5/weather?q=" ~ ($input.city|url_encode) ~ "&appid=" ~ $env.OPENWEATHER_API_KEY ~ "&units=" ~ $input.units
    }
    
    // Make the API request to OpenWeatherMap
    api.request {
      url = $api_url
      method = "GET"
      headers = ["Content-Type: application/json"]
      timeout = 30
    } as $weather_response
    
    // Handle different response statuses
    conditional {
      if ($weather_response.response.status == 200) {
        // Extract relevant weather data from response
        var $weather_data { value = $weather_response.response.result }
        
        var $temperature { value = $weather_data.main.temp }
        var $feels_like { value = $weather_data.main.feels_like }
        var $humidity { value = $weather_data.main.humidity }
        var $pressure { value = $weather_data.main.pressure }
        var $description { value = $weather_data.weather|first|get:"description":"unknown" }
        var $weather_main { value = $weather_data.weather|first|get:"main":"unknown" }
        var $wind_speed { value = $weather_data.wind.speed }
        var $city_name { value = $weather_data.name }
        var $country { value = $weather_data.sys.country }
        var $visibility { value = $weather_data.visibility }
        var $clouds { value = $weather_data.clouds.all }
        
        // Format the output
        var $result {
          value = {
            success: true,
            city: $city_name,
            country: $country,
            weather: {
              main: $weather_main,
              description: $description
            },
            temperature: {
              current: $temperature,
              feels_like: $feels_like,
              unit: $input.units == "imperial" ? "F" : ($input.units == "metric" ? "C" : "K")
            },
            humidity: $humidity,
            pressure: $pressure,
            wind_speed: $wind_speed,
            visibility: $visibility,
            clouds: $clouds,
            timestamp: now
          }
        }
      }
      elseif ($weather_response.response.status == 401) {
        throw {
          name = "AuthenticationError"
          value = "Invalid OpenWeatherMap API key. Please check your OPENWEATHER_API_KEY environment variable."
        }
      }
      elseif ($weather_response.response.status == 404) {
        throw {
          name = "NotFoundError"
          value = "City not found: " ~ $input.city ~ ". Please check the city name and try again."
        }
      }
      else {
        throw {
          name = "APIError"
          value = "OpenWeatherMap API returned status " ~ ($weather_response.response.status|to_text) ~ ": " ~ ($weather_response.response.result|json_encode)
        }
      }
    }
  }
  
  response = $result
}
