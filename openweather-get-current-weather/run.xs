run.job "OpenWeather Get Current Weather" {
  main = {
    name: "get_weather"
    input: {
      city: "San Francisco"
      units: "imperial"
      lang: "en"
    }
  }
  env = ["openweather_api_key"]
}
