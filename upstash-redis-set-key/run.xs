run.job "Upstash Redis Set Key" {
  main = {
    name: "set_redis_key"
    input: {
      key: "demo_key"
      value: "Hello from Xano Run Job!"
      ttl: 3600
    }
  }
  env = ["upstash_redis_rest_url", "upstash_redis_rest_token"]
}
