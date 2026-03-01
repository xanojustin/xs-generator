// Run job to test the Design Hit Counter
// Simulates recording hits and querying hit counts within a 5-minute window
run.job "Test Design Hit Counter" {
  main = {
    name: "hit_counter"
    input: {
      test_operations: [
        { action: "hit", timestamp: 1 },
        { action: "hit", timestamp: 2 },
        { action: "hit", timestamp: 3 },
        { action: "getHits", timestamp: 4 },
        { action: "hit", timestamp: 300 },
        { action: "getHits", timestamp: 300 },
        { action: "getHits", timestamp: 301 }
      ]
    }
  }
}
