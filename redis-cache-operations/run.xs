run.job "Redis Cache Operations" {
  main = {
    name: "cache_operations"
    input: {
      operation: "demo"
    }
  }
  env = ["REDIS_URL"]
}
