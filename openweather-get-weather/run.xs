run.job "OpenWeatherMap - Get Current Weather" {
  main = {
    name: "fetch_weather"
    input: {
      city: "San Francisco"
      units: "imperial"
    }
  }
  env = ["OPENWEATHER_API_KEY"]
}
