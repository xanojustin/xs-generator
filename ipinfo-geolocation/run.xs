run.job "IPinfo Geolocation Lookup" {
  main = {
    name: "lookup_ip"
    input: {
      ip: ""
    }
  }
  env = ["IPINFO_API_KEY"]
}
