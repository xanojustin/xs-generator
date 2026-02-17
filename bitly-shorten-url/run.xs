run.job "Bitly Shorten URL" {
  main = {
    name: "bitly_shorten"
    input: {
      long_url: "https://www.example.com/very/long/url/path/with/lots/of/parameters?foo=bar&baz=qux"
      domain: "bit.ly"
      title: "Example Shortened Link"
    }
  }
  env = ["bitly_api_token"]
}
