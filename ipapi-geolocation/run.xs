run.job "IPAPI Geolocation Lookup" {
  main = {
    name: "lookup_ip_location"
    input: {
      ip: "8.8.8.8"
    }
  }
  env = ["IPAPI_API_KEY"]
}
