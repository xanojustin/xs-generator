run.job "Post to X (Twitter)" {
  main = {
    name: "post_to_x"
    input: {
      text: "Hello from Xano Run Job! 🚀"
    }
  }
  env = ["X_API_KEY", "X_API_SECRET", "X_ACCESS_TOKEN", "X_ACCESS_SECRET"]
}
