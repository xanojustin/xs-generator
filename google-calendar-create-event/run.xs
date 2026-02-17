run.job "Google Calendar Create Event" {
  main = {
    name: "create_calendar_event"
    input: {
      summary: "Team Meeting - Xano Project Review"
      description: "Weekly sync to discuss Xano development progress and upcoming milestones."
      start_time: "2026-02-20T10:00:00"
      end_time: "2026-02-20T11:00:00"
      timezone: "America/Los_Angeles"
    }
  }
  env = ["google_access_token", "google_calendar_id"]
}
