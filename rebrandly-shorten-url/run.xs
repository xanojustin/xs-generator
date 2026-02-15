run.job "Rebrandly Shorten URL" {
  main = {
    name: "shorten_url"
    input: {
      destination: "https://www.example.com/very/long/url/that/needs/shortening"
      title: "Example Shortened Link"
    }
  }
  env = ["REBRANDLY_API_KEY"]
}
