run.job "IPInfo IP Intelligence Lookup" {
  main = {
    name: "lookup_ip_info"
    input: {
      ip: "8.8.8.8"
    }
  }
  env = ["IPINFO_API_KEY"]
}