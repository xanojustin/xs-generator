// Run job to test the LRU Cache implementation
run.job "Test LRU Cache" {
  main = {
    name: "lru_cache"
    input: {
      capacity: 2
      operations: [
        { action: "put", key: "a", value: 1 },
        { action: "put", key: "b", value: 2 },
        { action: "get", key: "a" },
        { action: "put", key: "c", value: 3 },
        { action: "get", key: "b" }
      ]
    }
  }
}
