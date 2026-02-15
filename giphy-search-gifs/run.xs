run.job "Giphy GIF Search" {
  main = {
    name: "search_gifs"
    input: {
      query: "funny cats"
      limit: 5
      rating: "g"
      lang: "en"
    }
  }
  env = ["giphy_api_key"]
}
