function "get_weather" {
  description = "Fetch current weather data from OpenWeather API for a given city"

  input {
    text city filters=trim|min:1 {
      description = "City name to fetch weather for (e.g., 'London', 'New York', 'Tokyo')"
    }

    text units?="metric" {
      description = "Temperature units: metric (Celsius), imperial (Fahrenheit), or standard (Kelvin)"
    }

    text lang?="en" {
      description = "Language code for weather description (e.g., 'en', 'es', 'fr')"
    }
  }

  stack {
    precondition (($env.openweather_api_key|strlen) > 0) {
      error_type = "standard"
      error = "OPENWEATHER_API_KEY environment variable is required"
    }

    precondition ($input.units == "metric" || $input.units == "imperial" || $input.units == "standard") {
      error_type = "inputerror"
      error = "Units must be 'metric', 'imperial', or 'standard'"
    }

    var $encoded_city {
      description = "URL-encode the city name for the API request"
      value = $input.city|url_encode
    }

    debug.log {
      description = "Log the weather request"
      value = "Fetching weather for city: " ~ $input.city ~ " (units: " ~ $input.units ~ ")"
    }

    api.request {
      description = "Call OpenWeather Current Weather API"
      url = "https://api.openweathermap.org/data/2.5/weather"
      method = "GET"
      params = {
        q: $encoded_city,
        appid: $env.openweather_api_key,
        units: $input.units,
        lang: $input.lang
      }
      headers = [
        "Content-Type: application/json"
      ]
      timeout = 30
    } as $api_response

    var $weather_main {
      description = "Extract main weather data (temp, feels_like, humidity, etc.)"
      value = $api_response|get:"main":null
    }

    var $weather_condition {
      description = "Extract weather condition array"
      value = $api_response|get:"weather":[]
    }

    var $weather_desc {
      description = "Extract weather description"
      value = ($weather_condition|first)|get:"description":"Unknown"
    }

    var $weather_icon {
      description = "Extract weather icon code"
      value = ($weather_condition|first)|get:"icon":"01d"
    }

    var $wind {
      description = "Extract wind data"
      value = $api_response|get:"wind":{}
    }

    var $clouds {
      description = "Extract cloud coverage"
      value = $api_response|get:"clouds":{}
    }

    var $sys {
      description = "Extract system data (country, sunrise, sunset)"
      value = $api_response|get:"sys":{}
    }

    var $temp_unit {
      description = "Determine temperature unit symbol based on units parameter"
      value = ($input.units == "imperial") ? "°F" : (($input.units == "standard") ? "K" : "°C")
    }

    var $speed_unit {
      description = "Determine wind speed unit based on units parameter"
      value = ($input.units == "imperial") ? "mph" : "m/s"
    }

    var $result {
      description = "Build the formatted weather response object"
      value = {
        success: true,
        city: $api_response|get:"name":$input.city,
        country: $sys|get:"country":"Unknown",
        coordinates: {
          lat: $api_response|get:"coord.lat":0,
          lon: $api_response|get:"coord.lon":0
        },
        weather: {
          main: ($weather_condition|first)|get:"main":"Unknown",
          description: $weather_desc,
          icon: "https://openweathermap.org/img/wn/" ~ $weather_icon ~ "@2x.png",
          icon_code: $weather_icon
        },
        temperature: {
          current: $weather_main|get:"temp":0,
          feels_like: $weather_main|get:"feels_like":0,
          min: $weather_main|get:"temp_min":0,
          max: $weather_main|get:"temp_max":0,
          unit: $temp_unit
        },
        atmosphere: {
          humidity: $weather_main|get:"humidity":0,
          pressure: $weather_main|get:"pressure":0
        },
        wind: {
          speed: $wind|get:"speed":0,
          direction: $wind|get:"deg":0,
          gust: $wind|get:"gust":0,
          unit: $speed_unit
        },
        clouds: $clouds|get:"all":0,
        visibility: $api_response|get:"visibility":0,
        timestamp: $api_response|get:"dt":0,
        sunrise: $sys|get:"sunrise":0,
        sunset: $sys|get:"sunset":0
      }
    }

    debug.log {
      description = "Log successful weather fetch"
      value = "Weather fetched successfully for " ~ $result.city ~ ", " ~ $result.country ~ " - " ~ $weather_desc
    }
  }

  response = $result
}
