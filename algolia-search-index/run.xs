run.job "Algolia Search Index Demo" {
  main = {
    name: "index_and_search"
    input: {
      index_name: "products"
      search_query: "laptop"
      max_results: 10
    }
  }
  env = ["ALGOLIA_APP_ID", "ALGOLIA_API_KEY", "ALGOLIA_SEARCH_KEY"]
}
