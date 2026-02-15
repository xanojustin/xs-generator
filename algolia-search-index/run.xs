run.job "Algolia Search Index" {
  main = {
    name: "search_index"
    input: {
      query: "laptop"
      index_name: "products"
      hits_per_page: 10
    }
  }
  env = ["ALGOLIA_APP_ID", "ALGOLIA_API_KEY", "ALGOLIA_SEARCH_KEY"]
}
