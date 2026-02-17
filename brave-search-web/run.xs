run.job "Brave Search - Web Search" {
  main = {
    name: "brave_web_search"
    input: {
      query: "Xano no-code backend platform"
      count: 10
      search_lang: "en"
      country: "US"
    }
  }
  env = ["BRAVE_API_KEY"]
}
