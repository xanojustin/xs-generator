// Run job to test the rate_limiter function
run.job "Test Rate Limiter" {
  main = {
    name: "rate_limiter"
    input: {
      requests: [
        { timestamp: 1, user_id: "user1" },
        { timestamp: 1, user_id: "user2" },
        { timestamp: 2, user_id: "user1" },
        { timestamp: 3, user_id: "user1" },
        { timestamp: 4, user_id: "user1" },
        { timestamp: 5, user_id: "user1" },
        { timestamp: 6, user_id: "user1" },
        { timestamp: 7, user_id: "user1" }
      ],
      limit: 5,
      window: 5
    }
  }
}
