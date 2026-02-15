run.job "Reddit Fetch Posts" {
  main = {
    name: "fetch_reddit_posts"
    input: {
      subreddit: "technology"
      sort_by: "hot"
      limit: 10
    }
  }
}