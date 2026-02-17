run.job "Geocode Address with Mapbox" {
  main = {
    name: "geocode_address"
    input: {
      address: "1600 Amphitheatre Parkway, Mountain View, CA"
      country: "us"
    }
  }
  env = ["mapbox_access_token"]
}
