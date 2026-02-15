run.job "NewsAPI Get Headlines" {
  main = {
    name: "get_headlines"
    input: {
      country: "us"
      category: "technology"
      page_size: "10"
      query: "artificial intelligence"
    }
  }
  env = ["NEWSAPI_KEY"]
}
