// WeatherAPI Current Weather Run Job
// Fetches current weather for a specified location

run.job "Fetch Current Weather" {
  main = {
    name: "fetch_current_weather"
    input: {
      location: "Los Angeles"
    }
  }
  env = ["WEATHER_API_KEY"]
}
