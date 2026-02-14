function "get_current_weather" {
  description = "Fetch current weather data from OpenWeatherMap API"
  input {
    text city filters=trim { description = "City name (e.g., London, New York, Tokyo)" }
    text units?="metric" filters=trim { description = "Units: metric, imperial, or kelvin (default: metric)" }
  }

  stack {
    // Get API key from environment
    var $api_key { value = $env.OPENWEATHER_API_KEY }

    // Validate API key is configured
    precondition ($api_key != null && $api_key != "") {
      error_type = "standard"
      error = "OPENWEATHER_API_KEY environment variable not configured"
    }

    // Validate city is provided
    precondition ($input.city != null && $input.city != "") {
      error_type = "inputerror"
      error = "City name is required"
    }

    // Validate units value
    conditional {
      if ($input.units != "metric" && $input.units != "imperial" && $input.units != "kelvin") {
        var $units { value = "metric" }
      }
      else {
        var $units { value = $input.units }
      }
    }

    // Build the API URL with query parameters
    var $base_url { value = "https://api.openweathermap.org/data/2.5/weather" }
    var $encoded_city { value = $input.city|url_encode }
    var $url {
      value = $base_url ~ "?q=" ~ $encoded_city ~ "&appid=" ~ $api_key ~ "&units=" ~ $units
    }

    // Send GET request to OpenWeatherMap
    api.request {
      url = $url
      method = "GET"
      headers = [
        "Accept: application/json"
      ]
      timeout = 30
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $temperature { value = null }
    var $feels_like { value = null }
    var $humidity { value = null }
    var $pressure { value = null }
    var $description { value = null }
    var $city_name { value = null }
    var $country { value = null }
    var $wind_speed { value = null }
    var $error_message { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status == 200) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }

        // Extract main weather data
        var $main { value = $response_body|get:"main" }
        conditional {
          if ($main != null) {
            var $temperature { value = $main|get:"temp" }
            var $feels_like { value = $main|get:"feels_like" }
            var $humidity { value = $main|get:"humidity" }
            var $pressure { value = $main|get:"pressure" }
          }
        }

        // Extract weather description
        var $weather_array { value = $response_body|get:"weather" }
        conditional {
          if ($weather_array != null && ($weather_array|count) > 0) {
            var $first_weather { value = $weather_array|first }
            conditional {
              if ($first_weather != null) {
                var $description { value = $first_weather|get:"description" }
              }
            }
          }
        }

        // Extract city info
        var $city_name { value = $response_body|get:"name" }
        var $sys { value = $response_body|get:"sys" }
        conditional {
          if ($sys != null) {
            var $country { value = $sys|get:"country" }
          }
        }

        // Extract wind data
        var $wind { value = $response_body|get:"wind" }
        conditional {
          if ($wind != null) {
            var $wind_speed { value = $wind|get:"speed" }
          }
        }
      }
      else {
        var $success { value = false }
        var $error_message {
          value = "OpenWeatherMap API error: HTTP " ~ ($api_result.response.status|to_text)
        }
        conditional {
          if ($api_result.response.result != null) {
            var $error_obj { value = $api_result.response.result|get:"message" }
            conditional {
              if ($error_obj != null) {
                var $error_message {
                  value = "OpenWeatherMap error: " ~ $error_obj
                }
              }
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    city: $city_name,
    country: $country,
    temperature: $temperature,
    feels_like: $feels_like,
    humidity: $humidity,
    pressure: $pressure,
    description: $description,
    wind_speed: $wind_speed,
    units: $units,
    error: $error_message
  }
}
