run.job "SerpAPI Google Search" {
  main = {
    name: "search_google"
    input: {
      query: "xano no code backend"
      location: "United States"
      language: "en"
      num_results: "10"
    }
  }
  env = ["SERPAPI_API_KEY"]
}
