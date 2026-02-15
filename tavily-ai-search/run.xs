run.job "Tavily AI Search" {
  main = {
    name: "tavily_search"
    input: {
      query: "latest developments in artificial intelligence"
      search_depth: "advanced"
      max_results: 5
      include_answer: true
    }
  }
  env = ["tavily_api_key"]
}
