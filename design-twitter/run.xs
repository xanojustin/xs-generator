run.job "Design Twitter Test" {
  main = {
    name: "twitter"
    input: {
      operation: "getNewsFeed"
      user_id: 1
    }
  }
}
