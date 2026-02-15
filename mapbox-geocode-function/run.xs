run.job "Mapbox Geocode Address" {
  main = {
    name: "geocode_address"
    input: {
      address: "1600 Pennsylvania Avenue NW, Washington, DC"
    }
  }
  env = ["mapbox_access_token"]
}
