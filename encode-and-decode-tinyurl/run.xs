run.job "Encode and Decode TinyURL" {
  main = {
    name: "tinyurl_service"
    input: {
      operation: "encode"
      url: "https://www.example.com/some/very/long/url/path"
    }
  }
}
