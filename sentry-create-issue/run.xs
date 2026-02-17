run.job "Sentry Create Issue" {
  main = {
    name: "sentry_create_issue"
    input: {
      message: "Error occurred in production environment"
      level: "error"
      environment: "production"
      platform: "javascript"
      tags: {
        component: "api-gateway"
        version: "1.2.3"
      }
      extra: {
        user_id: "12345"
        request_path: "/api/v1/users"
      }
    }
  }
  env = ["sentry_dsn"]
}
