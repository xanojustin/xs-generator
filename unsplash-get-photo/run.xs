run.job "Unsplash Get Random Photo" {
  main = {
    name: "get_photo"
    input: {
      query: "nature"
      orientation: "landscape"
    }
  }
  env = ["UNSPLASH_ACCESS_KEY"]
}
