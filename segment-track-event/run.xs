run.job "Segment Track Event" {
  main = {
    name: "track_event"
    input: {
      event: "User Signed Up"
      user_id: "user_12345"
      properties: {
        plan: "pro",
        source: "landing_page",
        campaign: "spring_2026"
      }
      context: {
        ip: "192.168.1.1"
      }
      timestamp: "2026-02-14T10:30:00Z"
    }
  }
  env = ["SEGMENT_WRITE_KEY"]
}