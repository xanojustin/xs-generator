run.job "PostHog Capture Event" {
  main = {
    name: "capture_event"
    input: {
      event: "page_view"
      distinct_id: "user_123"
      properties: {
        page: "/home"
        referrer: "google"
      }
    }
  }
  env = ["POSTHOG_API_KEY", "POSTHOG_HOST"]
}