// WeatherAPI Current Weather Function
// Fetches current weather data for a given location

function "fetch_current_weather" {
  input {
    text location
  }
  stack {
    // Validate input
    precondition ($input.location != null && $input.location != "") {
      error_type = "inputerror"
      error = "Location is required"
    }

    // Build API URL with location parameter
    var $encoded_location { 
      value = $input.location|url_encode 
    }

    var $api_url {
      value = "https://api.weatherapi.com/v1/current.json?key=" ~ $env.WEATHER_API_KEY ~ "&q=" ~ $encoded_location ~ "&aqi=yes"
    }

    // Make request to WeatherAPI
    api.request {
      url = $api_url
      method = "GET"
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_result

    // Check for successful response
    precondition ($api_result.response.status >= 200 && $api_result.response.status < 300) {
      error_type = "standard"
      error = "Weather API request failed with status: " ~ ($api_result.response.status|to_text)
    }

    // Extract current weather data
    var $current { value = $api_result.response.result.current }
    var $location_data { value = $api_result.response.result.location }

    // Build response object
    var $weather {
      value = {
        location: {
          name: $location_data.name,
          region: $location_data.region,
          country: $location_data.country,
          lat: $location_data.lat,
          lon: $location_data.lon,
          localtime: $location_data.localtime
        },
        current: {
          temp_c: $current.temp_c,
          temp_f: $current.temp_f,
          condition: $current.condition.text,
          condition_icon: $current.condition.icon,
          humidity: $current.humidity,
          wind_kph: $current.wind_kph,
          wind_mph: $current.wind_mph,
          wind_dir: $current.wind_dir,
          pressure_mb: $current.pressure_mb,
          feelslike_c: $current.feelslike_c,
          feelslike_f: $current.feelslike_f,
          vis_km: $current.vis_km,
          uv: $current.uv,
          air_quality: {
            co: $current.air_quality.co,
            no2: $current.air_quality.no2,
            o3: $current.air_quality.o3,
            so2: $current.air_quality.so2,
            pm2_5: $current.air_quality.pm2_5,
            pm10: $current.air_quality.pm10
          }
        }
      }
    }
  }
  response = $weather
}
