run.job "Sentry Create Issue" {
  description = "Create a Sentry issue/event to track errors or messages in your application"
  
  main = {
    name: "sentry_create_issue"
    input: {
      message: "An error occurred in the application"
      level: "error"
      environment: "production"
      platform: "javascript"
    }
  }
  
  env = ["sentry_dsn_public_key", "sentry_store_url"]
}
