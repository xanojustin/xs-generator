run.job "OpenWeatherMap Get Current Weather" {
  main = {
    name: "get_current_weather"
    input: {
      city: "London"
      units: "metric"
    }
  }
  env = ["OPENWEATHER_API_KEY"]
}
