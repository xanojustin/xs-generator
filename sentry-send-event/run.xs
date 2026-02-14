run.job "Send Sentry Event" {
  main = {
    name: "send_sentry_event"
    input: {
      message: "Test error event from Xano Run Job"
      level: "error"
      environment: "production"
    }
  }
  env = ["SENTRY_DSN", "SENTRY_PROJECT_ID"]
}
