run.job "Yelp Business Search" {
  main = {
    name: "search_businesses"
    input: {
      term: "coffee"
      location: "San Francisco, CA"
      limit: 10
      sort_by: "best_match"
      price: "1,2,3"
    }
  }
  env = ["yelp_api_key"]
}
