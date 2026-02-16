run.job "Bluesky Create Post" {
  main = {
    name: "bluesky_create_post"
    input: {
      text: "Hello from Xano! 🤖"
    }
  }
  env = ["bluesky_handle", "bluesky_password"]
}
